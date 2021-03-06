proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}

try {
    vsim -c work.adder_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.fa_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}