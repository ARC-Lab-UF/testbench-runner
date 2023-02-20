# New modelsim template tcl

##############################
# Variable declarations
# (filled in from script)
##############################
set proj_homedir "<PY_PROJ_HOMEDIR>"
set proj_name "<PY_PROJ_NAME>"

# make the directory first, so that GUI mode (if used)
# doesn't prompt you asking to create it.
mkdir -p $proj_homedir

# Create a new project
project new $proj_homedir $proj_name 

##############################
# Function definitions
##############################
# onElabError {resume}
# onerror {resume}

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}

proc runSimulation {testbench_filename} {
    try {
        vsim -c -quiet $testbench_filename
        add wave *
        run -all
    } on error {msg} {
        puts "SIMULATION FAILED"
        puts $msg
        set retry 1
        quit -sim
        puts "\n----------------------RETRY STUDENT SIMULATION-------------------------"
    }
}

proc currStudent {student} {
    puts "Now working on $student..."
    set retry 1
    while {$retry == 1} {
        set retry 0

        # TODO what do these lines do? Are they still required?
        vdel -all
        vlib work

        project calculateorder

        # Beginning of lab-specific tcl
        <PY_LAB_TESTBENCHES>
        # End of lab-specific tcl
    }
    puts "Done with $student."
}
# End of currStudent

# Student source files
<PY_STUDENT_SRC_FILES>

# Lab testbench files
<PY_ADD_TB_SRC_FILES>

currStudent "<PY_STUDENT_NAME>";



puts "Goodbye."
quit

