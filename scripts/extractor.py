"""
    extract.py

    Extracts student submissions from a 
    Canvas submissions.zip file.
"""
from pathlib import Path
import shutil
from typing import List
from zipfile import ZipFile
from .student_data import StudentData


def extract_submissions(
    lab_filename: str,
    section_students: List[StudentData],
    submissions_zip_path: Path,
    delete_zip: bool,
) -> List[StudentData]:
    """Extracts specific student submissions out of a .zip of every student submission.

    Args:
        - lab_filename: Folder name to call the lab (e.g., "Lab5")

        - section_students: List of StudentData objects representing the students enrolled
                            in the CLI-supplied class section. WARNING: section_students will 
                            be modified as a side effect of extract_submissions()!

        - submissions_zip_path: Path to submissions.zip

        - delete_zip: Whether submissions.zip should be deleted once
                      extraction of pertinent students is finished.
    Returns:
        A new list of StudentData, which is a subset of section_students, that contains
        student information of those who submitted a .zip file for the current Lab, and
        therefore have an unzipped directory with their submission in submissions/Labx.
    """
    # Create the unzipped submissions directory, which will be used to store each students' source code.
    SUBS_UNZIP_PATH = Path("submissions/", lab_filename)
    SUBS_UNZIP_PATH.mkdir(parents=True, exist_ok=True)

    with ZipFile(submissions_zip_path) as z:
        all_zip_filenames = z.namelist()

        # Figure out which ones we need based on the section_students
        students_with_submission: List[StudentData] = []
        
        non_zip_files = []  # In case a student submitted a PDF or something, still extract it.
        for student in section_students:
            for file in all_zip_filenames:
                if student.mangled_name in file:  # Ignore non-zip archives
                    if file.endswith('.zip'):
                        student.zipped_submission = file
                        students_with_submission.append(student)
                    else:
                        student.other_file = file
                        non_zip_files.append(file)
                
        print(f"There should be {len(students_with_submission)} zip files in the submission dir.")
        # Extract those students' .zip files into the submissions/Labx dir.
        z.extractall(SUBS_UNZIP_PATH, [s.zipped_submission for s in students_with_submission] + non_zip_files)

    # For each student submission subdir, extract contents and copy all VHDL files to the top.
    for student in students_with_submission:

        # Create a directory for this student's submission.  # TODO this could just use the normal name.
        student.submission_dir = SUBS_UNZIP_PATH / student.name  # Path / operator concatenates/appends paths
        student.submission_dir.mkdir(parents=True, exist_ok=True)

        # Extract all of the submission's contents into the new directory.
        with ZipFile(Path(SUBS_UNZIP_PATH, student.zipped_submission)) as z:
            z.extractall(student.submission_dir)

        # Find all the VHDL files in this submission
        student.vhdl_files = list(Path(student.submission_dir).rglob("*.[vV][hH][dD]*"))

        # If student has non zip-archive submissions, move them into the submission directory.
        if student.other_file:
            try:
                shutil.move(SUBS_UNZIP_PATH / student.other_file, student.submission_dir)
            except shutil.Error as e:
                print(e)
                pass
        
    # Remove the student submission .zip files from submissions/Labx
    for student in students_with_submission:  # TODO bug, in lab4 alexander barrera shows up twice. For some reason alex has two submissions, a zip and a pdf. weird.
        # Path.unlink() removes the file
        Path(SUBS_UNZIP_PATH, student.zipped_submission).unlink()

    # If user chooses, delete submissions.zip
    if delete_zip:
        try:
            Path(submissions_zip_path).unlink()  # Remove path
        except FileNotFoundError as e:
            print('An error occurred while attempting to delete "submissions.zip".')
            print(e)

    # Return student data of students with submissions (and VHDL path info filled out)
    return students_with_submission
