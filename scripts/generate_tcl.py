import shutil
from typing import List
from pathlib import Path

from .student_data import StudentData


def get_testbench_paths(lab_name: str) -> List[str]:
    lab_tb_dir = Path("lab-testbenches") / lab_name
    tb_paths = [str(path.resolve().as_posix()) for path in lab_tb_dir.glob("*.vhd")]
    return tb_paths


def copy_mif_files(lab_name: str, dest: Path):
    lab_tb_dir = Path("lab-testbenches") / lab_name
    mif_paths = [str(path.resolve().as_posix()) for path in lab_tb_dir.glob("*.mif")]
    for mif_path in mif_paths:
        shutil.copy2(mif_path, dest)


def generate_tcl(
    student_data: List[StudentData],
    lab_tcl_file: Path,
    lab_name: str,
):
    """generate_tcl creates a TCL script for ModelSim that
    grades each students' lab via the given true testbenches."""

    resultList = []
    print("-" * 18)
    print("Students to grade:")
    for i, student in enumerate(student_data, start=1):
        print(f"{i}. {student.name}")

        file_list = "\n".join(f'project addfile "{vhdl_file.resolve().as_posix()}"' for vhdl_file in student.vhdl_files)

        resultList.append([file_list, student.name])

    print("-" * 18)

    with open(lab_tcl_file) as f:
        LAB_TCL = f.read()

    with open("tcl-templates/common.tcl") as f:
        ORIGINAL_TCL = f.read()

    # Add tcl to add students' source files to the project
    for student, (file_add_cmds, tcl_name) in zip(student_data, resultList):
        # Insert project path and name
        SIM_DIR = student.submission_dir / "modelsim"
        SIM_DIR.mkdir(exist_ok=True)  # Make the modelsim directory

        # Insert testbench files
        lab_testbench_paths = get_testbench_paths(lab_name)
        lab_testbench_cmds = [f"project addfile \"{p}\"" for p in lab_testbench_paths]

        # Insert all relevant text into script
        tcl = ( 
            ORIGINAL_TCL
            .replace("<PY_LAB_TESTBENCHES>", LAB_TCL) 
            .replace("<PY_PROJ_HOMEDIR>", SIM_DIR.resolve().as_posix())
            .replace("<PY_PROJ_NAME>", f"{student.name}_{lab_name}")
            .replace("<PY_STUDENT_SRC_FILES>", file_add_cmds)
            .replace("<PY_STUDENT_NAME>", tcl_name)
            .replace("<PY_ADD_TB_SRC_FILES>", "\n".join(lab_testbench_cmds))
        )

        # Write resulting TCL script to a file
        SIM_SCRIPT_PATH = SIM_DIR / "run.do"
        with open(SIM_SCRIPT_PATH, "w") as f:
            f.write(tcl)

        # Give the student their tcl filepath.
        student.sim_script = SIM_SCRIPT_PATH

        # If any mif files exist in the lab folder, copy them into each modelsim project.
        copy_mif_files(lab_name, SIM_DIR)

