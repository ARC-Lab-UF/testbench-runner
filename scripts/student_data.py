from dataclasses import dataclass, field
from pathlib import Path
from typing import List, Optional


@dataclass
class StudentData:
    # Normal name ("First Last")
    name: str

    # Non-zip archive files (e.g., if student submits a PDF)
    other_file: Optional[str] = None

    # Zipped submission filename
    # TODO explain why this has a default value of "". Probably in case of `other_file is not None`?
    zipped_submission: str = ""

    # Unzipped submission directory
    submission_dir: Path = Path()

    # Path to this student's simulation .do script.
    sim_script: Path = Path()

    # Path of each VHDL file for this student
    vhdl_files: List[Path] = field(default_factory=list)

    # Name that appears in canvas zip files ("lastfirstmiddle(s)")
    @property
    def mangled_name(self) -> str:
        """Returns Canvas-autoformatted name for a student.
        The formatting is [middle name(s)]<lastname><firstname>."""
        separated_names = self.name.lower().split()
        middles_last_first = "".join(separated_names[1:] + [separated_names[0]])
        return middles_last_first
