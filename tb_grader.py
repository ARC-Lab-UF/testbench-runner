"""
Random number generator for student labs

@author: keethsmith
"""

import argparse
import os
from scripts.zip_function import zip_opener
from scripts.sim_function import compile_modelsim


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='automated random list generator for labs.')

    parser.add_argument('-lab','--lab', type=str, help='duration of slot in minutes. Default is 10', required=True)
    parser.add_argument('-submissions','--submissions',default="submissions.zip",type=str,help='file of student names, separated by new line', required=False)
    parser.add_argument('-tclOutFile','--tclOutFile', default="scripts/lab4_out.tcl", type=str, help='location of modified tcl file', required=True)
    parser.add_argument('-tclFile','--tclFile', default="scripts/lab4.tcl", type=str, help='location of original tcl file', required=True)
    parser.add_argument('-gui', '--gui', default=False, type=lambda x: (str(x).lower() in ['true','1', 'yes']), help='Option to enable GUI (True | False)')
    parser.add_argument('-studentFile','--studentFile',default="studentList.txt",type=str,help='file of student names, separated by new line', required=False)
    parser.add_argument('-project_mpf','--project_mpf',default="../Tester 21/Lab4/Lab4.mpf",type=str,help='location of modelsim tb project mpf file', required=True)

    args = parser.parse_args()



    zip_opener(lab=args.lab, studentFile=args.studentFile, submissions=args.submissions)

    compile_modelsim(studentFile=args.studentFile, lab_dir = (os.path.join("Submissions",args.lab)), tclFile = args.tclFile, tclOutFile = args.tclOutFile, project_mpf = args.project_mpf, gui = args.gui)


# example: python tb_grader.py -lab Lab5 -submissions submissions.zip -tclOutFile "../Tester 21/Lab5/Lab5_out.tcl" -tclFile "lab_tcl/lab5.tcl" -studentFile "studentList.txt" -project_mpf "../Tester 21/Lab5/Lab5.mpf"
