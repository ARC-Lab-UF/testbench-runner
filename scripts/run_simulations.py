import subprocess
# from subprocess import DEVNULL
from typing import List
from .student_data import StudentData

def run_simulations(students: List[StudentData], gui: bool) -> None:
    # Run modelsim (-l "" disables ModelSim logging)
    cmd = lambda gui, do_file: f"vsim {'-gui' if gui else '-c'} -l \"\" -do \"{do_file}\""

    total_num_students = len(students)

    for i, student in enumerate(students, start=1): 
        # restart = True
        ran_once = False
        while True:
            print()
            print("-"*40)
            print(f"({i}/{total_num_students}) {student.name}")
            if ran_once:
                print("- Press return to move to next student")
                print("- Press r to rerun simulation")  # Technically any unused key works too
            else:
                print("- Press return to run simuation")
            print("- Press n to skip this student")
            print("- Press q to quit")
            print("-"*40)

            choice = input()
            if choice == "q":
                return
            elif ran_once and choice == "":  # Pressed enter
                break
            elif choice == "n":  # Skip this student
                break

            # Run the simulation
            subprocess.run(
                cmd(gui, student.sim_script), shell=True, stdout=True
            )

            ran_once = True



