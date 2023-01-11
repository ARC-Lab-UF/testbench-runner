# ----------------------------------------------------------
#                           IMPORTS
# ----------------------------------------------------------

import argparse
import csv
import os
from scripts.extractor import extract_submissions
from scripts.sim_function import compile_modelsim
from scripts.student_data import StudentData
from pathlib import Path

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

# ----------------------------------------------------------
#                           MAIN
# ----------------------------------------------------------

def main():

    parser = argparse.ArgumentParser(description="Interactive ModelSim testbench runner for Digital Design labs.")

    # Required arguments
    # ----------------------------------------------------------
    # Lab number
    parser.add_argument("-l", "--lab", help='Example: "Lab5"', required=True)

    # location of modified TCL file
    parser.add_argument("--tcl-out-file", help="location of modified tcl file", required=True)

    # location of original TCL file
    parser.add_argument("--tcl-file", help="location of original tcl file", required=True)

    # location of modelsim testbench project file
    parser.add_argument("--project-mpf", default="Modelsim_tb 21/Lab4/Lab4.mpf",
                        help="location of modelsim tb project mpf file", required=True)

    # Optional arguments
    # ----------------------------------------------------------

    # submissions.zip location
    parser.add_argument("-s", "--submissions", default="submissions.zip", help='location of "submissions.zip" file')

    mutex_group = parser.add_mutually_exclusive_group()

    mutex_group.add_argument("--student-list", default="students.txt",
                             help="Text file of student names to be graded. See studentList_EXAMPLE.txt.")

    mutex_group.add_argument("--section", help='Section number of student section to be graded (e.g., "12345")')

    # --all-students-file is only necessary when --section is used.
    # However, due to current Python STL limitations, I can't include
    # it as a subgroup to the mutex_group. Weird.
    # Just ignore it if --section is None.
    parser.add_argument("--all-students-file", help="CSV file of all students, from Canvas.",
                        default="all_students.csv")

    # Optional Flags (True if included, otherwise False)
    # ----------------------------------------------------------
    parser.add_argument("--gui", action="store_true", help="Show ModelSim window during simulation")
    parser.add_argument("--delete-zip", action="store_true", help="Delete submissions.zip file when done")
    parser.add_argument("--debug", action="store_true", help="Display argparse tokens and exit")

    # ----------------------------------------------------------
    args = parser.parse_args()

    # Get list of students, either via section number, or a students.txt file.
    students = read_student_csv(args.all_students_file, args.section) if args.section else read_student_text(args.student_list)

    students_with_submission = extract_submissions(
        lab_filename=args.lab,
        section_students=students,
        submissions_zip_path=args.submissions,
        delete_zip=args.delete_zip,
    )

    compile_modelsim(
        student_data=students_with_submission,
        lab_dir=(os.path.join("Submissions", args.lab)),
        tcl_file=args.tcl_file,
        tcl_out_file=Path(args.tcl_out_file),
        project_mpf=args.project_mpf,
        gui=args.gui,
    )


if __name__ == "__main__":
    main()
