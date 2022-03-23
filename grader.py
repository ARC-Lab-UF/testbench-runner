import argparse
import csv
import os
from scripts.extractor import extract_submissions
from scripts.sim_function import compile_modelsim
from scripts.student_data import StudentData


def main():
    parser = argparse.ArgumentParser(
        description="Interactive ModelSim testbench runner for Digital Design labs."
    )

    # Required arguments

    # Lab number
    parser.add_argument("-l", "--lab", help='Example: "Lab5"', required=True)

    parser.add_argument(
        "--tcl-out-file", help="location of modified tcl file", required=True
    )

    parser.add_argument(
        "--tcl-file", help="location of original tcl file", required=True
    )

    parser.add_argument(
        "--project-mpf",
        default="Modelsim_tb 21/Lab4/Lab4.mpf",
        help="location of modelsim tb project mpf file",
        required=True,
    )

    # Optional args

    # submissions.zip location
    parser.add_argument(
        "-s",
        "--submissions",
        default="submissions.zip",
        help='location of "submissions.zip" file',
    )

    mutex_group = parser.add_mutually_exclusive_group()

    mutex_group.add_argument(
        "--student-list",
        default="students.txt",
        help="Text file of student names to be graded. See studentList_EXAMPLE.txt.",
    )

    mutex_group.add_argument(
        "--section",
        help='Section number of student section to be graded (e.g., "12345")',
    )

    # --all-students-file is only necessary when --section is used.
    # However, due to current Python STL limitations, I can't include
    # it as a subgroup to the mutex_group. Weird.
    # Just ignore it if --section is None.
    parser.add_argument(
        "--all-students-file",
        help="CSV file of all students, from Canvas.",
        default="all_students.csv",
    )

    # Flags (True if included, otherwise False)

    parser.add_argument(
        "--gui", action="store_true", help="Show ModelSim window during simulation"
    )

    parser.add_argument(
        "--delete-zip",
        action="store_true",
        help="Delete submissions.zip file when done",
    )  # TODO consider removing, not that helpful

    parser.add_argument(
        "--debug", action="store_true", help="Display argparse tokens and exit"
    )

    args = parser.parse_args()
    
    # Get list of students, either via section number, or a students.txt file.
    if args.section:
        # Read the all_students.csv file
        with open(args.all_students_file) as f:
            contents = csv.DictReader(f)
            # Filter to just the students in the specified section
            students_in_section = [s for s in contents if args.section in s['Section']]
        # CSV file is formatted "<Last>, <First>". Format to "<First> <Last>" for consistency with students.txt file.
        students = [StudentData(' '.join(reversed(stu["Student"].split(', ')))) for stu in students_in_section]
    else:
        with open(args.student_list) as f:
            students = [StudentData(name) for name in f.readlines()]

    print(f'{students=}')
    print(f'length: {len(students)}')
    
    students_with_submission = extract_submissions(
        lab_filename=args.lab,
        section_students=students,
        submissions_zip_path=args.submissions,
        delete_zip=args.delete_zip,
    )

    # TODO use `students` here instead of `args.student_list` because student_list isn't always used.
    compile_modelsim(
        student_data=students_with_submission,
        lab_dir=(os.path.join("Submissions", args.lab)),
        tclFile=args.tcl_file,
        tclOutFile=args.tcl_out_file,
        project_mpf=args.project_mpf,
        gui=args.gui,
    )


if __name__ == "__main__":
    main()
