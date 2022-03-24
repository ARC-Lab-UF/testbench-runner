from textwrap import dedent
from typing import List
import subprocess
from subprocess import DEVNULL
from pathlib import Path

from scripts.student_data import StudentData


def generate_tcl(
    student_data: List[StudentData],
    tcl_file: Path,
    tcl_out_file: Path,
    project_mpf: Path,
    gui: bool,
):
    """generate_tcl creates a TCL script for ModelSim that
    grades each students' lab via the given true testbenches."""

    resultList = []
    print("-" * 18)
    print("Students to grade:")
    for i, student in enumerate(student_data, start=1):
        print(f"{i}. {student.name}")

        fileList = ""
        for vhdl_file in student.vhdl_files:
            fileList += f'project addfile "{vhdl_file.resolve().as_posix()}"\n'  # Posix paths work with Modelsim (/ instead of \)

        resultList.append([fileList, student.name])

    print("-" * 18)

    with open(tcl_file) as f:
        lab_tcl = f.read()

    with open("tcl-templates/common.tcl") as f:
        tcl = (
            f.read()
            .replace("PY_PROJ_MPF_PATH", project_mpf.resolve().as_posix())
            .replace("PY_LAB_TCL", lab_tcl)
        )

    for x in resultList:

        tcl += dedent(
            """
            quietly set result [string map -nocase {"\} \{" "\}\\n\{" "\} " "\}\\n" ".vhd " ".vhd\\n"} [project filenames]] 
            quietly set lines [split $result "\\n"]

            foreach x $lines {
            if {[string match *true_testbench.vhd* $x] == 1} {
                set z 1
            } else {
                #   puts "REMOVED"
                eval project removefile $x
            }
            } 

        """
        )

        tcl += x[0]

        tcl += dedent(
            """
            quietly set ret [project compileall -n]
            quietly set result [string map {explicit "quiet -suppress 1195,1194" \\\ / } $ret]
            quietly set lines [split $result "\\n"]
        """
        )

        tcl += f"""\ncurrStudent $lines "{x[1]}";\n\n"""

    tcl += "exit"

    # Write resulting TCL script to a file
    with open(tcl_out_file, "w") as f:
        f.write(tcl)

    # Run modelsim (-l "" disables ModelSim logging)
    cmd = f"vsim {'-gui' if gui else '-c'} -l \"\" -do \"{tcl_out_file.resolve()}\""
    subprocess.run(
        cmd, shell=True, stdout=True, stderr=DEVNULL
    )  # TODO verify these arguments are what we want
