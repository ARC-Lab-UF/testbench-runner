#!/usr/bin/env python
__author__ = "Keeth Smith"

import os
from typing import List
import glob
import subprocess
from pathlib import Path
from subprocess import DEVNULL

from scripts.tcl_function import tcl_function
from scripts.student_data import StudentData


def compile_modelsim(
    student_data: List[StudentData],
    lab_dir: str,
    tclFile: str,
    tclOutFile: str,
    project_mpf: str,
    gui: bool,
):

    resultList = []
    print("\nStudents Found:")
    for student in student_data:
        print(student.name)

        fileList = ""
        for vhdl_file in student.vhdl_files:
            fileList += (
                "project addfile {"
                + f"{vhdl_file.resolve()}".replace(os.sep, "/")
                + "}\n"
            )

        resultList.append([fileList, student.name])

    print()

    tcl_out = tcl_function(tclFile, project_mpf, resultList)

    with open(os.path.abspath(tclOutFile), "w+") as f:
        f.write(tcl_out)

    if gui:
        cmd = f'''vsim -gui -l "" -do "{os.path.abspath(tclOutFile)}"'''
    else:
        cmd = f'''vsim -c -l "" -do "{os.path.abspath(tclOutFile)}"'''

    try:
        subprocess.run(cmd, shell=True, stdout=True, stderr=DEVNULL)
    except:
        print(""" Something didn't work... ¯\_(ツ)_/¯ """)
