
try {
    vsim -c -quiet work.adder_true_testbench_config
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    set retry 1
    quit -sim
    puts "\n----------------------RETRY STUDENT SIMULATION-------------------------"
}