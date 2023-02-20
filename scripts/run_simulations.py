import subprocess
# from subprocess import DEVNULL
from typing import List
from .student_data import StudentData

def run_simulations(students: List[StudentData], gui: bool) -> None:
    # Run modelsim (-l "" disables ModelSim logging)
    cmd = lambda gui, do_file: f"vsim {'-gui' if gui else '-c'} -l \"\" -do \"{do_file}\""

    for i, student in enumerate(students, start=1): 

        restart = True
        while restart:
            print()
            print("-"*40)
            print(f"{i}. {student.name}")
            print("- Press return to (re)run simulation")
            print("- Press n to move to next student")
            print("- Press q to quit the autograder")
            print("-"*40)

            choice = input()
            if choice == "n":
                restart = False
                continue
            elif choice == "q":
                exit()

            subprocess.run(
                cmd(gui, student.sim_script), shell=True, stdout=True
            )

