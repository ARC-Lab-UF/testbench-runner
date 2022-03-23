#!/usr/bin/env python
__author__ = "Keeth Smith"

import os
from typing import List
import glob
import subprocess
from pathlib    import Path
from subprocess import DEVNULL

from scripts.tcl_function import tcl_function
from scripts.student_data import StudentData

def compile_modelsim(
    student_data: List[StudentData], 
    lab_dir: str, 
    tclFile: str,
    tclOutFile: str, 
    project_mpf: str,
    gui: bool
):

    cmd  = ""
    fileList = ""
    # studentUserList = []

    # with open(studentFile, "r") as f:
    #     studentList = f.read().splitlines()
    #     studentList = filter(None, studentList)
    #     for x in studentList:
    #         list_name = x.lower().split()
    #         if (len(list_name) == 3):
    #             studentUserList.append(list_name[1] + list_name[2] + list_name[0])

    #         else:
    #             studentUserList.append(list_name[1] + list_name[0])

    

    resultList=[]
    print("\nStudents Found:")
    for student_name in student_names:
        try:
            realStudent = glob.glob(lab_dir+"/*"+student_name+"*")[0].split('\\''')[-1]
            print(realStudent)
            dirPath = os.path.join(lab_dir , realStudent )
            result = list(Path(dirPath).glob("*.[vV][hH][dD]"))
            fileList = ""
            for y in result:
                fileList += 'project addfile {' + f'{os.path.abspath(y)}'.replace(os.sep,'/')+ '}\n'
                
            resultList.append([fileList,realStudent])
        except:
            pass

    print()

    tcl_out = tcl_function(tclFile, project_mpf, resultList)
        



    with open(os.path.abspath(tclOutFile), "w+") as f:
        f.write(tcl_out)


   

    if gui:
        cmd  = f'''vsim -gui -l "" -do "{os.path.abspath(tclOutFile)}"'''
    else:
        cmd  = f'''vsim -c -l "" -do "{os.path.abspath(tclOutFile)}"'''



    try:
        subprocess.run(cmd, shell=True, stdout=True, stderr=DEVNULL)
    except:
        print(''' Something didn't work... ¯\_(ツ)_/¯ ''')
