from dataclasses import dataclass, field
from pathlib import Path
from typing import List


@dataclass
class StudentData:
    # Normal name ("First Last")
    name: str

    # Zipped submission filename
    zipped_submission: str = ""

    # Unzipped submission directory
    submission_dir: Path = Path()

    # Path of each VHDL file for this student
    vhdl_files: List[Path] = field(default_factory=list)

    # Name that appears in canvas zip files ("lastfirstmiddle(s)")
    @property
    def mangled_name(self) -> str:
        separated_names = self.name.lower().split()
        separated_names = reversed(separated_names)  # Reverse first,last
        return "".join(separated_names)
