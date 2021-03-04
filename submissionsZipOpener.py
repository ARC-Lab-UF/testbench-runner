"""
Random number generator for student labs

@author: keethsmith
"""

import argparse
import datetime
import os
from pathlib import Path
import sys
import codecs
import re
import glob
import shutil
import random
import zipfile
from os import path
from zipfile import ZipFile
from datetime import datetime, timedelta
from shutil import copyfile
import subprocess
from subprocess import DEVNULL




def zip_opener(lab, studentFile, submissions):

    studentUserList=[]
    fileList=[]

    with open(studentFile, "r") as f:
        studentList = f.read().splitlines()
        for x in studentList:
            studentUserList.append( ''.join(x.lower().split()[::-1]) )


    with ZipFile(submissions, 'r') as zipObj:
        subfile = zipObj.namelist()


    for x in subfile:
        for y in studentUserList:
            z = (x.split('_'))
            if ( y in x ):
                fileList.append(x)


    pathDir = os.path.join("Submissions/",lab)
    Path(pathDir).mkdir(parents=True, exist_ok=True)

    

    # if ( not path.exists(pathDir) ):
    #     os.mkdir(pathDir)


    with zipfile.ZipFile(submissions) as z:
            z.extractall(pathDir, fileList)

    vhdl_list = []

    try:
        for x in fileList:
            
            newDir = os.path.join(pathDir,x.split(".zip")[0].split('_')[0])
            # print(x.split(".zip")[0].split('_')[0])
            os.mkdir( newDir )

            
            
            with zipfile.ZipFile( os.path.join(pathDir, x) ) as z:
                z.extractall(newDir)

                result = list(Path(newDir).rglob("*.[vV][hH][dD]*"))
                # print(result)
                y=[]
                for x in result:
                    try: 

                        shutil.copy2(x, newDir)
                        y.append(os.path.join(os.getcwd(), x))

                    except:
                        pass
                
            vhdl_list.append(y)
                # print(y)


    except:
        pass

    for x in fileList:
        os.remove( os.path.join(pathDir, x) )


    # os.remove("submissions.zip")

    print("DONE")



def compile_modelsim(studentFile="studentList.txt", lab_dir = "Submissions/Lab4", tclFile="scripts/lab4.tcl", tclOutFile="scripts/lab4_out.tcl", project_mpf = "../Tester 21/Lab4/", gui = False):

    tcl = ""
    cmd  = ""
    fileList = ""
    studentUserList = []

    with open(studentFile, "r") as f:
        studentList = f.read().splitlines()
        for x in studentList:
            studentUserList.append(''.join(x.lower().split()[::-1]) )

    resultList=[]
    for x in studentUserList:
        try:
            realStudent = glob.glob(lab_dir+"/*"+x+"*")[0].split('\\''')[-1]
            print(realStudent)
            dirPath = os.path.join(lab_dir , realStudent )
            result = list(Path(dirPath).glob("*.[vV][hH][dD]*"))
            fileList = ""
            for y in result:
                fileList += 'project addfile {' + f'{os.path.abspath(y)}'.replace(os.sep,'/')+ '}\n'
                
            resultList.append([fileList,realStudent])
        except:
            pass


    with open(tclFile, "r") as f:
        tclScript = f.read()
    

    tcl = '''project open '''
    tcl += '{' + f'{os.path.abspath(project_mpf)}' + '}\n\n'

    for x in resultList:
        tcl += '''onElabError {resume}\nonerror {resume}\nproc currStudent {lines { '''
    
        tcl += f'''message "\nEnter 'q' to exit\nEnter 'n' for next student\nPress Control-C to break out if stuck\nNow working on {x[1]} '''

        tcl += '''Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }
'''
        tcl += tclScript + '''\n}\n\n'''

            
        tcl += ''' 
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

'''
        tcl += x[0]
        tcl += '''
quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\\ /} $ret]
quietly set lines [split $result "\\n"]'''
        tcl += '''\ncurrStudent $lines;\n\n'''


    tcl += 'exit'
        



    with open(os.path.abspath(tclOutFile), "w+") as f:
        f.write(tcl)


   

    if gui:
        cmd  = f'''vsim -gui -do "{os.path.abspath(tclOutFile)}"'''
    else:
        cmd  = f'''vsim -c -do "{os.path.abspath(tclOutFile)}"'''



    try:
        subprocess.run(cmd, shell=True, stdout=True, stderr=DEVNULL)
    except:
        print(''' Something didn't work... ¯\_(ツ)_/¯ ''')


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='automated random list generator for labs.')

    parser.add_argument('-lab','--lab', type=str, help='duration of slot in minutes. Default is 10', required=True)
    parser.add_argument('-submissions','--submissions',default="submissions.zip",type=str,help='file of student names, separated by new line', required=False)
    parser.add_argument('-tclOutFile','--tclOutFile', default="scripts/lab4_out.tcl", type=str, help='location of modified tcl file', required=True)
    parser.add_argument('-tclFile','--tclFile', default="scripts/lab4.tcl", type=str, help='location of original tcl file', required=True)
    parser.add_argument('-gui', '--gui', default=False, type=lambda x: (str(x).lower() in ['true','1', 'yes']), help='Option to enable GUI (True | False)')
    parser.add_argument('-studentFile','--studentFile',default="studentList.txt",type=str,help='file of student names, separated by new line', required=False)
    # parser.add_argument('-lab_dir','--lab_dir',default="Submissions/Lab4",type=str,help='location of lab directory for student submissions', required=True)
    parser.add_argument('-project_mpf','--project_mpf',default="../Tester 21/Lab4/Lab4.mpf",type=str,help='location of modelsim tb project mpf file', required=True)

    args = parser.parse_args()



    zip_opener(lab=args.lab, studentFile=args.studentFile, submissions=args.submissions)

    compile_modelsim(studentFile=args.studentFile, lab_dir = (os.path.join("Submissions",args.lab)), tclFile = args.tclFile, tclOutFile = args.tclOutFile, project_mpf = args.project_mpf, gui = args.gui)


    # example: python submissionsZipOpener.py -lab Lab5 -submissions submissions.zip -tclOutFile "scripts/lab5_out.tcl" -tclFile "scripts/lab5.tcl" -studentFile "studentList.txt" -project_mpf "../Tester 21/Lab5/Lab5.mpf"
