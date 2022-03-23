"""
    extract.py

    Extracts student submissions from a 
    Canvas submissions.zip file.
"""
import shutil
from pathlib import Path
from typing import List
from zipfile import ZipFile
from .student_data import StudentData


def extract_submissions(
    lab_filename: str,
    section_students: List[StudentData],
    submissions_zip_path: str,
    delete_zip: bool,
):
    """Extracts specific student submissions out of a .zip of every student submission.

    Args:
        - lab_filename: Folder name to call the lab (e.g., "Lab5")

        - section_students: List of StudentData objects representing the students enrolled
                            in the CLI-supplied class section.

        - submissions_zip_path: Path to submissions.zip

        - delete_zip: Whether submissions.zip should be deleted once
                      extraction of pertinent students is finished.
    """

    # # Get list of all student submissions
    # with ZipFile(submissions_zip_path, "r") as z:
    #     all_zip_filenames = z.namelist()

    # # Get subset of students in the section that have zip files in the submissions.zip.
    # # In layman's terms, get the subset of students who submitted something for this assignment.
    # STUDENTS_WITH_SUBMISSION = [
    #     student
    #     for student in section_students
    #     for zip_filename in all_zip_filenames
    #     if student.mangled_name in zip_filename
    # ]

    


    # Create the unzipped Submissions directory, which will be used to store each students' source code.
    SUBS_UNZIP_PATH = Path("Submissions/", lab_filename)
    SUBS_UNZIP_PATH.mkdir(parents=True, exist_ok=True)

    with ZipFile(submissions_zip_path) as z:
        all_zip_filenames = z.namelist()

        # Figure out which ones we need based on the section_students
        students_with_submission: List[StudentData] = []
        for student in section_students:
            for zip_filename in all_zip_filenames:
                if student.mangled_name in zip_filename:
                    student.zipped_submission = zip_filename
                    students_with_submission.append(student)
        print(f"There should be {len(students_with_submission)} zip files in the submission dir.")
        # Extract those students' .zip files into the Submissions/Labx dir.
        z.extractall(SUBS_UNZIP_PATH, [s.zipped_submission for s in students_with_submission])



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

    # Remove the student submission .zip files from Submissions/Labx
    for student in students_with_submission:
        # Path.unlink() removes the file
        Path(SUBS_UNZIP_PATH, student.zipped_submission).unlink()

    # If user chooses, delete submissions.zip
    if delete_zip:
        try:
            Path(submissions_zip_path).unlink()  # Remove path
        except FileNotFoundError as e:
            print('An error occurred while attempting to delete "submissions.zip".')
            print(e)
