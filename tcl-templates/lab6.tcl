
try {
    vsim -c -quiet work.vga_final_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    set retry 1
    quit -sim
    puts "\n----------------------RETRY STUDENT SIMULATION-------------------------"
}