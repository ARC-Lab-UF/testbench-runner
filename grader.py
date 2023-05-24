__version__ = "1.0"
import argparse
import csv
from pathlib import Path
from scripts import extract_submissions, generate_tcl, StudentData, run_simulations
from shutil import which
from typing import List
import subprocess


def read_student_csv(csv_file: Path, section: str) -> List[StudentData]:
    """Returns a list of the students in a particular section from an
    exported Canvas gradebook, as StudentData objects."""
    # Read the all_students.csv file
    with open(csv_file) as file:
        contents = csv.DictReader(file)

        # Filter to just the students in the specified section
        students_in_section = [
            stu_obj for stu_obj in contents if section in stu_obj["Section"]
        ]

    # CSV file is formatted "<Last>, <First>". Format to "<First> <Last>" for consistency with students.txt file.
    students = [
        StudentData(" ".join(reversed(stu_obj["Student"].split(", "))))
        for stu_obj in students_in_section
    ]
    return students


def read_student_text(text_file: Path) -> List[StudentData]:
    """Return a list of students from a text file, as StudentData objects."""
    # Read the students.txt file
    with open(text_file) as file:
        students = [StudentData(name.strip(" \n")) for name in file.readlines()]
    return students


def generate_tcl_mpf_filenames(lab_num: int):
    """Given a lab number, generate the filepaths
    to relevant tcl files and modelsim project files."""
    # TODO this doesn't really need to be in its own
    # function anymore, since it doesn't do much anymore.
    lab = "lab{}".format(lab_num)
    tcl_file = "tcl-templates/lab{}.tcl".format(lab_num)

    return lab, Path(tcl_file)


def check_vsim_command():
    """Verify that `vsim` is an operable command.
    Otherwise, the tool will crash."""

    # List of officially supported versions
    # TODO probably should be moved to a file somewhere, but whatever
    SUPPORTED_VSIM = [
        "Model Technology ModelSim - INTEL FPGA STARTER EDITION vsim 2020.1 Simulator 2020.02 Feb 28 2020\n\n"
    ]

    if which("vsim") is None:
        print("!" * 30)
        print("WARNING: `vsim` executable not found.")
        print("The autograder will fail when it attempts to run `vsim` later!")
        print("!" * 30)

    else:
        stdout = subprocess.run(
            ["vsim", "-version"], capture_output=True, encoding="utf-8"
        ).stdout

        if stdout not in SUPPORTED_VSIM:
            print("!" * 30)
            print("WARNING: `vsim` is not a supported version for the grader tool.")
            print(f"You're using version: {repr(stdout)}")
            print("The autograder may fail when it attempts to run `vsim` later!")
            print("!" * 30)


def main():
    parser = argparse.ArgumentParser(
        description="Automatically run HDL testbenches from Canvas' submission format."
    )

    parser.add_argument(
        "-v", "--version", action="version", version=f"testbench-runner {__version__}"
    )

    # Required arguments
    # ----------------------------------------------------------

    parser.add_argument(
        "-l", "--lab", type=int, help='Lab number (e.g., "5").', required=True
    )

    # Optional arguments
    # ----------------------------------------------------------

    parser.add_argument(
        "-s",
        "--submissions",
        type=Path,
        default="submissions.zip",
        help='Path to "submissions.zip" file.',
    )

    # Either supply student-list XOR section number (and an all_students.csv file)
    mutex_group = parser.add_mutually_exclusive_group()

    mutex_group.add_argument(
        "--student-list",
        type=Path,
        default="students.txt",
        help="Text file of student names to be extracted and simulated. See students_example.txt.",
    )

    mutex_group.add_argument(
        "--section",
        help='Section number to be graded (e.g., "12345" or "0001"). Used instead of --student-list.',
    )

    # NOTE: --all-students-file is only necessary when --section is used.
    # However, due to current Python STL limitations, I can't include
    # it as a subgroup to the mutex_group. Weird.
    # Just ignore it if --section is None.
    parser.add_argument(
        "--all-students-file",
        type=Path,
        default="all_students.csv",
        help="Path to CSV file of all students enrolled in the course, from Canvas (see README.md for instructions on obtaining).",
    )

    # Flags
    # ----------------------------------------------------------

    parser.add_argument(
        "--delete-zip",
        action="store_true",
        help="WARNING: Delete submissions.zip file when done.",
    )
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Developer: Display argparse tokens and exit.",
    )

    # ----------------------------------------------------------

    args = parser.parse_args()

    # TODO this can be inlined
    lab, tcl_file = generate_tcl_mpf_filenames(args.lab)

    # Get list of students, either via section number, or a students.txt file.
    students = (
        read_student_csv(args.all_students_file, args.section)
        if args.section
        else read_student_text(args.student_list)
    )

    students_with_submission = extract_submissions(
        lab_filename=lab,
        section_students=students,
        submissions_zip_path=args.submissions,
        delete_zip=args.delete_zip,
    )

    check_vsim_command()

    generate_tcl(
        student_data=students_with_submission,
        lab_tcl_file=tcl_file,
        lab_name=lab,
    )

    run_simulations(
        students=students_with_submission,
    )


if __name__ == "__main__":
    main()
