import subprocess
# from subprocess import DEVNULL
from typing import List
from .student_data import StudentData

def run_simulations(students: List[StudentData]) -> None:

    total_num_students = len(students)

    for i, student in enumerate(students, start=1): 
        # restart = True
        ran_once = False

        while True:
            # Whether to run the simulation in ModelSim GUI window, or in the CLI.
            # This should reset every time the prompt is displayed.
            gui = False

            print()
            print("-"*40)
            print(f"({i}/{total_num_students}) {student.name}")
            if ran_once:
                print("- Press return to move to next student")
                print("- Press r to rerun simulation")  # Technically any unused key works too
                print("- Press g to rerun simulation in the ModelSim GUI")
            else:
                print("- Press return to run simuation")  # Technically any unused key works too
                print("- Press g to run simulation in the ModelSim GUI")
            print("- Press n to skip this student")
            print("- Press q to quit")
            print("-"*40)

            choice = input("> ")
            if choice == "q":
                return
            elif ran_once and choice == "":  # Pressed enter
                break
            elif choice == "n":  # Skip this student
                break
            elif choice == "g":
                gui = True
                print("Notes about the GUI:")
                print('- If prompted with "A project of this name already exists. Do you want to overwrite it?", select "Yes".')
                print('- To spend more time in the GUI, select "No" when prompted to quit. The grader will continue to new students whenever you choose to quit the GUI.\n')

            # Create the command to run modelsim
            # Run modelsim (-l "" disables ModelSim logging)
            cmd = lambda gui, do_file: f"vsim {'-gui' if gui else '-c'} -l \"\" -do \"{do_file}\""

            # Run the simulation
            subprocess.run(
                cmd(gui, student.sim_script), shell=True, stdout=True
            )

            ran_once = True



