"""
    extract.py

    Extracts student submissions from a 
    Canvas submissions.zip file.
"""
import os
import shutil
from pathlib import Path
from typing import List
from zipfile import ZipFile


def _format_student_names(student_list_file: str) -> List[str]:
    """Format student names as they appear in their mangled submissions.zip directories."""
    with open(student_list_file, "r") as f:
        names = f.readlines()

    formatted_names = []
    for name in names:
        # Name formatting is all lowercase, no spaces.
        separated_names = name.lower().split()

        # Formatting of submissions.zip simply puts first name in the back.
        formatted_names.append("".join([*separated_names[1:], separated_names[0]]))

    return formatted_names


def extract_submissions(
    lab_filename: str,
    student_list_file: str,
    submissions_zip_path: str,
    delete_zip: bool,
):
    """
    Extracts specific student submissions out of a .zip of every student submission.

    Args:
        - lab_filename: Folder name to call the lab (e.g., "Lab5")

        - student_list_file: Path to student list text file.

        - submissions_zip_path: Path to submissions.zip

        - delete_zip: Whether submissions.zip should be deleted once
                      extraction of pertinent students is finished.
    """

    # Get list of formatted student namnes
    formatted_names = _format_student_names(student_list_file)

    # Get list of all student submissions
    with ZipFile(submissions_zip_path, "r") as z:
        subfile = z.namelist()

    # Get cooresponding mangled submission .zip filenames from inside submissions.zip
    zip_filenames = [
        zip_name 
        for zip_name in subfile 
        for name in formatted_names 
        if name in zip_name
    ]

    # Create the unzipped Submissions directory, which will be used to store each students' source code.
    SUBS_UNZIP_PATH = os.path.join("Submissions/", lab_filename)
    Path(SUBS_UNZIP_PATH).mkdir(parents=True, exist_ok=True)

    # Extract only the mangled names we selected into the new submission directory.
    with ZipFile(submissions_zip_path) as z:
        z.extractall(SUBS_UNZIP_PATH, zip_filenames)

    # For each student submission subdir, extract contents and copy all VHDL files to the top.
    for zip_filename in zip_filenames:

        # Create a directory for this student's submission.  # TODO this could just use the normal name.
        STU_UNZIP_PATH = os.path.join(SUBS_UNZIP_PATH, zip_filename.split("_")[0])
        Path(STU_UNZIP_PATH).mkdir(parents=True, exist_ok=True)

        # Extract all of the submission's contents into the new directory.
        with ZipFile(os.path.join(SUBS_UNZIP_PATH, zip_filename)) as z:
            z.extractall(STU_UNZIP_PATH)

        # Find all the VHDL files in this submission
        vhdl_files = list(Path(STU_UNZIP_PATH).rglob("*.[vV][hH][dD]*"))

        # Copy them to the top of the dir
        for f in vhdl_files:
            if "vga_rom" in str(f):  # TODO why skip vga_rom?
                continue

            try:
                shutil.copy2(f, STU_UNZIP_PATH)
            except shutil.SameFileError:
                pass

    # Remove the old student submission .zip files
    for zip_filename in zip_filenames:
        os.remove(os.path.join(SUBS_UNZIP_PATH, zip_filename))

    # If user chooses, delete submissions.zip
    if delete_zip:
        try:
            os.remove(submissions_zip_path)
        except:
            print('An error occurred while attempting to delete "submissions.zip".')

    # Return this so the other functions can know where to look for these files. TODO just send the paths directly.
    return formatted_names
