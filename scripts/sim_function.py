#!/usr/bin/env python
__author__ = "Keeth Smith"

import os
import sys
import glob
import subprocess
from pathlib    import Path
from subprocess import DEVNULL

from scripts.tcl_function import tcl_function


def compile_modelsim(studentFile="studentList.txt", lab_dir = "Submissions/Lab4", tclFile="scripts/lab4.tcl", tclOutFile="scripts/lab4_out.tcl", project_mpf = "../Tester 21/Lab4/", gui = False):

    cmd  = ""
    fileList = ""
    studentUserList = []

    with open(studentFile, "r") as f:
        studentList = f.read().splitlines()
        studentList = filter(None.__ne__, studentList)
        for x in studentList:
            studentUserList.append(''.join(x.lower().split()[::-1]) )

    resultList=[]
    for x in studentUserList:
        try:
            realStudent = glob.glob(lab_dir+"/*"+x+"*")[0].split('\\''')[-1]
            print(realStudent)
            dirPath = os.path.join(lab_dir , realStudent )
            result = list(Path(dirPath).glob("*.[vV][hH][dD]"))
            fileList = ""
            for y in result:
                fileList += 'project addfile {' + f'{os.path.abspath(y)}'.replace(os.sep,'/')+ '}\n'
                
            resultList.append([fileList,realStudent])
        except:
            pass


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
