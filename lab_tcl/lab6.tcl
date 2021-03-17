
try {
    vsim -c -quiet work.vga_final_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}