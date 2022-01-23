import argparse
import os
from scripts.zip_function import zip_opener
from scripts.sim_function import compile_modelsim


def main():
    parser = argparse.ArgumentParser(
        description="Interactive ModelSim testbench runner for Digital Design labs."
    )

    # Required arguments
    # TODO make some of these positional arguments (remove - and --)

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

    parser.add_argument(
        "--student-list",
        default="students.txt",
        help="Text file of student names to be graded. See studentList_EXAMPLE.txt.",
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


    zip_opener(
        lab=args.lab,
        studentFile=args.student_list,
        submissions=args.submissions,
        delete_zip=args.delete_zip,
    )


    compile_modelsim(
        studentFile=args.student_list,
        lab_dir=(os.path.join("Submissions", args.lab)),
        tclFile=args.tcl_file,
        tclOutFile=args.tcl_out_file,
        project_mpf=args.project_mpf,
        gui=args.gui,
    )


if __name__ == "__main__":
    main()
