
try {
    vsim -c -quiet work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}