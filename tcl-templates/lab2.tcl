proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}

try {
    vsim -c -quiet work.alu_ns_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    set retry 1
    quit -sim
    puts "\n----------------------RETRY STUDENT SIMULATION-------------------------"
}

pause;

try {
    vsim -c -quiet work.alu_sla_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    set retry 1
    quit -sim
    puts "\n----------------------RETRY STUDENT SIMULATION-------------------------"
}

pause;

try {
    vsim -c -quiet work.decoder7seg_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    set retry 1
    quit -sim
    puts "\n----------------------RETRY STUDENT SIMULATION-------------------------"
}