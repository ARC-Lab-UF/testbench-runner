from typing import List
import subprocess
from subprocess import DEVNULL
from pathlib import Path

from .student_data import StudentData


def get_testbench_paths(lab_name: str) -> List[str]:
    lab_tb_dir = Path("lab-testbenches") / lab_name
    tb_paths = [str(path.resolve()) for path in lab_tb_dir.glob("*.vhd")]
    return tb_paths

def generate_tcl(
    student_data: List[StudentData],
    tcl_file: Path,
    lab_name: str,
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
        LAB_TCL = f.read()

    with open("tcl-templates/common.tcl") as f:
        ORIGINAL_TCL = f.read().replace("<PY_LAB_TESTBENCHES>", LAB_TCL)

    # A list of tcl filepaths to be ran via modelsim.
    do_files = []

    # Add tcl to add students' source files to the project
    for student, (file_add_cmds, tcl_name) in zip(student_data, resultList):
        # Restart tcl 
        # TODO does this make a copy? Let's hope so
        tcl = ORIGINAL_TCL

        # Insert project path and name
        SIM_DIR = student.submission_dir / "modelsim"
        SIM_DIR.mkdir()  # Make the modelsim directory

        tcl = tcl.replace("<PY_PROJ_HOMEDIR>", str(SIM_DIR))
        tcl = tcl.replace("<PY_PROJ_NAME>", f"{student.name}_{lab_name}")

        # Insert student source files
        tcl = tcl.replace("<PY_STUDENT_SRC_FILES>", file_add_cmds)
        tcl = tcl.replace("<PY_STUDENT_NAME>", tcl_name)

        # Insert testbench files
        lab_testbench_paths = get_testbench_paths(lab_name)
        lab_testbench_cmds = [f"project addfile \"{p}\"" for p in lab_testbench_paths]
        # TODO see how they're made above, and eventually make this a function
        tcl = tcl.replace("<PY_ADD_TB_SRC_FILES>", "\n".join(lab_testbench_cmds))

        # Write resulting TCL script to a file
        tcl_out_filepath = SIM_DIR / "run.do"
        with open(tcl_out_filepath, "w") as f:
            f.write(tcl)
            # Add this file to the list
            do_files.append(tcl_out_filepath)

    # Run modelsim (-l "" disables ModelSim logging)
    # For now, just run each instance one at a time.
    for do_file in do_files:
        cmd = f"vsim {'-gui' if gui else '-c'} -l \"\" -do \"{do_file}\""

        subprocess.run(
            cmd, shell=True, stdout=True, stderr=DEVNULL
        )

        input("Press Return for next simulation")
