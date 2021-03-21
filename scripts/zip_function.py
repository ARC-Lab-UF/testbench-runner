#!/usr/bin/env python
__author__ = "Keeth Smith"

import os
import zipfile
import shutil
import pathlib
from shutil     import copyfile
from os         import path
from pathlib    import Path
from zipfile    import ZipFile




def zip_opener(lab, studentFile, submissions, delete_zip):

    studentUserList=[]
    fileList=[]
    print()

    with open(studentFile, "r") as f:
        studentList = f.read().splitlines()
        studentList = filter(None, studentList)
        for x in studentList:
            list_name = x.lower().split()
            if (len(list_name) == 3):
                studentUserList.append(list_name[1] + list_name[2] + list_name[0])

            else:
                studentUserList.append(list_name[1] + list_name[0])

    submissions_file_path = pathlib.Path(os.path.abspath(submissions))

    if not submissions_file_path.exists():
        print("\nCANT FIND ZIP FILE")
        return



    with ZipFile(os.path.abspath(submissions), 'r') as zipObj:
        subfile = zipObj.namelist()


    for x in subfile:
        for y in studentUserList:
            z = (x.split('_'))
            if ( y in x ):
                fileList.append(x)


    pathDir = os.path.join("Submissions/",lab)
    Path(pathDir).mkdir(parents=True, exist_ok=True)


    with zipfile.ZipFile(os.path.abspath(submissions)) as z:
            z.extractall(pathDir, fileList)

    vhdl_list = []

    
    for x in fileList:
        try: 
            newDir = os.path.join(pathDir,x.split(".zip")[0].split('_')[0])
            Path(newDir).mkdir(parents=True, exist_ok=True)
        except:
            print("failed file List")

        try:    
        
            with zipfile.ZipFile( os.path.join(pathDir, x) ) as z:
                z.extractall(newDir)

                result = list(Path(newDir).rglob("*.[vV][hH][dD]*"))
                y=[]
                for x in result:
                    if 'vga_rom' in str(x):
                        continue

                    try: 
                        shutil.copy2(x, newDir)
                        y.append(os.path.join(os.getcwd(), x))

                    except:
                        pass
                
            vhdl_list.append(y)


        except:
            print(f"{x}: falied zip")
            pass

    for x in fileList:
        os.remove( os.path.join(pathDir, x) )

    if (delete_zip):
        try:
            os.remove(os.path.abspath(submissions))
        except:
            print("Couldn't Delete Zip File")


