# testbench-runner

An interactive testbench runner for HDL. Uses ModelSim under the hood. Integrates with Canvas assignments for easy grading.

### Table of contents

* [Prerequisites](https://github.com/benjamin051000/DD_Grader#prerequisites)
* [Usage](https://github.com/benjamin051000/DD_Grader#usage)
  * [1. Select Students to Grade](https://github.com/benjamin051000/DD_Grader#1-select-students-to-grade)
  * [2. Download Canvas Submissions](https://github.com/benjamin051000/DD_Grader#2-download-canvas-submissions)
  * [3. Run grader.py](https://github.com/benjamin051000/DD_Grader#3-run-graderpy)
* [Using the interactive Testbench Runner](https://github.com/benjamin051000/DD_Grader#using-the-interactive-testbench-runner)

# Prerequisites

### 1. ModelSim

Install ModelSim via [this link](https://fpgasoftware.intel.com/20.1/?edition=lite&product=modelsim_ae&platform=windows)

The tool will verify ModelSim is installed and an appropriate version on startup.


### 2. Python

You can download Python from [this link](https://www.python.org/downloads/).

You can verify Python is working properly by running `python -V` in a terminal window. It should print something similar to:
```bash
$ python -V
Python 3.10.1
```

**Note:** DD_Grader has been tested with Python **3.10.1** and is not guaranteed to work on other versions.

# Usage
## 1. Select Students to Grade
There are two methods to select students to grade: By section number, or via a list of names.

<details><summary>Select by Section Number</summary>

To use the `--section` flag, a file named `all_students.csv` must be downloaded to the project directory. This file contains information about students in the course, including each students' section number.
### Download Student Data

1. Navigate to the course gradebook on Canvas.
2. Click "Actions > Export" as shown in the below image.

![Image showing the highlighted export button the user should press in the Canvas gradebook to download a CSV of students in the course](images/export-students.png)

Save this file as `all_students.csv` in the root directory (the same directory as this README file). It should be structured similarly to `all_students_example.csv`, but may include additional information, like assignment grades.

When running the grader, use `--section <section number>` to specify a section number you wish to grade. Section numbers are 5-digit numbers seen in the parentheses on a students' section ID string. For example, in the class/section identifier `EEL4712C-0001(11624)`, `11624` is the section number.
</details>
<br/>
<details><summary>Select by Student List</summary>

To choose specific students for grading, make a text file with the students' names.

Use the same format as `students_example.txt`, which is `<FirstName> [Middle name(s)] <LastName>` per line.

Finally, use the default `students.txt` filename, or specify the file path in the CLI args via `--student-list <path>`.
</details>
<br/>

## 2. Download Canvas Submissions

On the Canvas Assignment page, press "Download submissions". 

![Image showing where to find the "Download Submissions" button on the Canvas Assignment page](images/download-submissions.png)

This will collect *all* student submissions and download them in one file titled `submissions.zip`.


Copy `submissions.zip` into the project directory, or specify the zip archive path in the CLI args via `--submissions <path>`.

## 3. Run `grader.py`

To run the testbenches for Lab 1 with all default values (a "submissions.zip" folder and a "students.txt" file in the project root directory), run the following command:

```bash
python grader.py --lab 1
```
If you want to use a section, you must provide the `--section` flag:

```bash
python grader.py --lab 1 --section 12345
```

Be sure to supply values for `--submissions`, `--student-list`, or `--all-students-file` if they do not use the default file name.

## Other options and flags

### `submissions.zip` path

To specify a path for the submissions.zip file, use `--submissions <path>`.
This can be useful if you want to maintain multiple labs' worth of submissions. You can rename the file to `submissions_lab2.zip` for example, and specify this name in the CLI args.

# Using the Interactive Testbench Runner

After running a command to start the grader, the program will print the students it was able to find in the `submissions.zip` file.
Then, ModelSim will begin running, and a prompt will appear:
```
----------------------------------------
(1/9) Student name
- Press return to move to next student
- Press r to rerun simulation
- Press g to rerun simulation in the ModelSim GUI
- Press n to skip this student
- Press q to quit
----------------------------------------
> <type your response here>
```
Pressing return will either run the simulation for the first time, or move to the next student.

If multiple testbenches are used to grade a particular lab, the simulator will ask the user to press `Enter` to continue on to the next testbench.

