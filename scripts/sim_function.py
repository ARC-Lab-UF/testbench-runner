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
    tcl_file: str,
    tcl_out_file: Path,
    project_mpf: str,
    gui: bool,
):

    resultList = []
    print("\nStudents Found:")
    for student in student_data:
        print(student.name)

        fileList = ""
        for vhdl_file in student.vhdl_files:
            fileList += f'project addfile "{vhdl_file.resolve().as_posix()}"\n'  # Posix paths work with Modelsim (uses / instead of \\)

        resultList.append([fileList, student.name])

    print()

    tcl_out = tcl_function(tcl_file, project_mpf, resultList)

    with open(os.path.abspath(tcl_out_file), "w+") as f:
        f.write(tcl_out)

    # Run modelsim (-l "" disables ModelSim logging)
    cmd = f"vsim {'-gui' if gui else '-c'} -l \"\" -do \"{tcl_out_file.resolve()}\""
    print(Path.cwd())
    print(f"{cmd=}")
    subprocess.run(
        cmd, shell=True, stdout=True, stderr=DEVNULL
    )  # TODO verify these arguments are what we want
