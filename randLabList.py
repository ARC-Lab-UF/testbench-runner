#!/usr/bin/env python

"""
Random number generator for student labs

@author: keethsmith
"""

## Sample command to run:  python randLabList.py -t "04:05 PM" -f studentList.txt -d 10


import argparse
import datetime
import os
import sys
import re
import random
from datetime import datetime, timedelta

parser = argparse.ArgumentParser(description='automated random list generator for labs.')
parser.add_argument('-t', '--time', default="4:05 PM", type=str, help='lab start time, format: HH:MM AM/PM. Please account for quiz time -- if quiz is 20 min and start is 3:00PM then put 3:20PM as start time', required=False)
parser.add_argument('-d','--duration', default="10" , type=str, help='duration of slot in minutes. Default is 10', required=False)
parser.add_argument('-f','--file',default="studentList.txt",type=str,help='file of student names, separated by new line', required=False)
args = parser.parse_args()

pTime = args.time.replace(" ","")
startTime = datetime.strptime(pTime, "%I:%M%p")

if(args.duration!=None):
    duration = int(args.duration)
studentFile = None
if(args.file!=None):
    if(os.path.isfile(args.file)):
        studentFile = args.file
    else:
        print("Error: could not open "+str(args.file))
        sys.exit(-1)


with open(studentFile, "r") as f:
    studentList = f.read().splitlines()

#shuffle the student list
random.shuffle(studentList)


# ENTER STUDENTS THAT CANT TAKE THE QUIZ BEFORE LAB
chosen_ones = ["John Doe", "Jane Doe"]

for chosen_one in chosen_ones:

    if chosen_one in studentList:

        studentList.remove(chosen_one)
        studentList.insert(random.randint(5,len(studentList)), chosen_one)




for student in studentList:

    print(str(startTime.strftime("%I:%M %p"))+" - "+str(student))
    startTime = startTime + timedelta(minutes=duration)