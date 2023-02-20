# New modelsim template tcl

# Create variables (filled in from script)
set proj_homedir ./temp/lab5
set proj_name albertgator
set testbench_name work.all_gcd_true_testbench

# make the directory first, so that GUI mode (if used)
# doesn't prompt you asking to create it.
mkdir -p $proj_homedir

# Create a new project
project new $proj_homedir $proj_name 

# Add testbench files
# (Will be filled in by python)
project addfile "../../modelsim-projects/Lab5/all_gcd_true_testbench.vhd"
project addfile "../../Submissions/comparator.vhd"
project addfile "../../Submissions/ctrl1.vhd"
project addfile "../../Submissions/ctrl2.vhd"
project addfile "../../Submissions/datapath1.vhd"
project addfile "../../Submissions/datapath2.vhd"
project addfile "../../Submissions/decoder7seg.vhd"
project addfile "../../Submissions/gcd_tb.vhd"
project addfile "../../Submissions/gcd.vhd"
project addfile "../../Submissions/mux2x1.vhd"
project addfile "../../Submissions/reg.vhd"
project addfile "../../Submissions/subtractor.vhd"
project addfile "../../Submissions/top_level.vhd"

puts "Compiling..."
project calculateorder
# For some reason, when running in -c mode, the following line doesn't output until we rerun vsim...
# All compile dependencies have been resolved.vsim -c work.all_gcd_true_testbench 
puts "\nDone compiling.\n"

puts "------------------------------"
puts "Running simulation..."
puts "------------------------------"
try {
    vsim $testbench_name
    add wave *
    run -all
} on error {msg} {
    puts "------------------------------"
    puts "Simulation Failed:"
    puts $msg
    puts "------------------------------"
}

puts "Done. Goodbye."
quit 

