project open {PY_PROJ_MPF_PATH}

onElabError {resume}
onerror {resume}

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

proc currStudent {lines student} {
    set retry 1
    while {$retry == 1} {
        set retry 0
        puts -nonewline "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on $student Hit Enter to continue ==> "
        flush stdout
        set in [gets stdin]
        if {$in == "q"} {
            set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]]
            set lines [split $result "\n"]

            foreach x $lines {
                if {[string match *true_testbench.vhd* $x] == 1} {
                    set z 1
                } else {
                    eval project removefile [string map -nocase { "\{\{" "\{" "\}\}" "\}" } $x]
                }
            }
            quit -f
        }
        if {$in == "n"} {
            return
        }
        vdel -all
        vlib work
        for {set i 1} {$i<=2} {incr i} {
            puts "\n--------------COMPILE ATTEMPT: $i--------------\n"
            foreach x $lines {
                try {
                    eval $x

                } on error {msg} {
                    puts ""
                }

            }
            if {$i == 2} {
                puts "COMPILE PASSED SUCCESSFULLY\n\n--------------STARTING SIMULATION--------------\n"
            }
        }

        # Beginning of lab-specific tcl
        PY_LAB_TCL
        # End of lab-specific tcl
    }
}
# End of currStudent
