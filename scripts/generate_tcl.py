from typing import List
from pathlib import Path
from .student_data import StudentData


def get_testbench_paths(lab_name: str) -> List[str]:
    """Return all testbenches defined for this lab."""
    lab_tb_dir = Path("lab-testbenches") / lab_name
    tb_paths = [str(path.resolve().as_posix()) for path in lab_tb_dir.glob("*.vhd")]
    return tb_paths


def generate_tcl(
    student_data: List[StudentData],
    lab_tcl_file: Path,
    lab_name: str,
):
    """Create a TCL script per student that compiles and simulates each testbench in the lab assignment."""

    resultList = []
    print("-" * 18)
    print("Students to grade:")
    for i, student in enumerate(student_data, start=1):
        print(f"{i}. {student.name}")

        file_list = "\n".join(
            f'project addfile "{vhdl_file.resolve().as_posix()}"'
            for vhdl_file in student.vhdl_files
        )

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
        lab_testbench_cmds = [f'project addfile "{p}"' for p in lab_testbench_paths]

        # Insert all relevant text into script
        tcl = (
            ORIGINAL_TCL.replace("<PY_LAB_TESTBENCHES>", LAB_TCL)
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
