# ----------------------------------------------------------
#                           IMPORTS
# ----------------------------------------------------------

import argparse
import csv
from pathlib import Path
from scripts import extract_submissions, generate_tcl, StudentData, run_simulations

# ----------------------------------------------------------
#                           METHODS
# ----------------------------------------------------------

def read_student_csv(csv_file, section):
    # Read the all_students.csv file
    with open(csv_file) as file:
        contents = csv.DictReader(file)

        # Filter to just the students in the specified section
        students_in_section = [stu_obj for stu_obj in contents if section in stu_obj['Section']]

    # CSV file is formatted "<Last>, <First>". Format to "<First> <Last>" for consistency with students.txt file.
    students = [StudentData(' '.join(reversed(stu_obj["Student"].split(', ')))) for stu_obj in students_in_section]
    return students

def read_student_text(text_file):
    # Read the students.txt file
    with open(text_file) as file:
        students = [StudentData(name.strip(' \n')) for name in file.readlines()]
    return students

def generate_tcl_mpf_filenames(lab_num: int):
    """Given a lab number, generate the filepaths 
    to relevant tcl files and modelsim project files."""
    lab = "lab{}".format(lab_num)
    project_mpf = "modelsim-projects/Lab{}/Lab{}.mpf".format(lab_num, lab_num)
    tcl_file = "tcl-templates/lab{}.tcl".format(lab_num)
    tcl_out_file = "modelsim-projects/Lab{}/Lab{}_out.tcl".format(lab_num, lab_num)

    return lab, Path(project_mpf), Path(tcl_file), Path(tcl_out_file)


# ----------------------------------------------------------
#                           MAIN
# ----------------------------------------------------------

def main():

    parser = argparse.ArgumentParser(description="Interactive ModelSim testbench runner for Digital Design labs.")

    # Required arguments
    # ----------------------------------------------------------
    # Lab number
    parser.add_argument("-l", "--lab", type=int, help='Lab number (e.g., "5").', required=True)

    # Optional arguments
    # ----------------------------------------------------------

    # submissions.zip location
    parser.add_argument(
        "-s",
        "--submissions",
        type=Path,
        default="submissions.zip",
        help='Path to "submissions.zip" file.',
    )

    mutex_group = parser.add_mutually_exclusive_group()

    mutex_group.add_argument(
        "--student-list",
        type=Path,
        default="students.txt",
        help="Text file of student names to be graded. See students_example.txt.",
    )

    mutex_group.add_argument("--section", help='Section number to be graded (e.g., "12345"). Used instead of --student-list.')

    # --all-students-file is only necessary when --section is used.
    # However, due to current Python STL limitations, I can't include
    # it as a subgroup to the mutex_group. Weird.
    # Just ignore it if --section is None.
    parser.add_argument(
        "--all-students-file",
        type=Path,
        default="all_students.csv",
        help="Path to CSV file of all students enrolled in the course, from Canvas (see README.md for instructions on obtaining).",
    )

    # Optional Flags (True if included, otherwise False)
    # ----------------------------------------------------------
    parser.add_argument("--gui", action="store_true", help="Show ModelSim window during simulation.")
    parser.add_argument("--delete-zip", action="store_true", help="WARNING: Delete submissions.zip file when done.")
    parser.add_argument("--debug", action="store_true", help="Developer: Display argparse tokens and exit.")

    # ----------------------------------------------------------
    args = parser.parse_args()

    lab, project_mpf, tcl_file, tcl_out_file = generate_tcl_mpf_filenames(args.lab)

    # Get list of students, either via section number, or a students.txt file.
    students = read_student_csv(args.all_students_file, args.section) if args.section else read_student_text(args.student_list)

    students_with_submission = extract_submissions(
        lab_filename=lab,
        section_students=students,
        submissions_zip_path=args.submissions,
        delete_zip=args.delete_zip,
    )

    # TODO use `students` here instead of `args.student_list` because student_list isn't always used.
    generate_tcl(
        student_data=students_with_submission,
        lab_tcl_file=tcl_file,
        lab_name=lab,
    )

    run_simulations(
        students=students_with_submission,
        gui=args.gui
    )


if __name__ == "__main__":
    main()
