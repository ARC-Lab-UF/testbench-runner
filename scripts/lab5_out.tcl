project open {C:\Users\keeth\Desktop\TA folder\Spring 21\Tester 21\Lab5\Lab5.mpf}

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on agarwalsahil Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/comp.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/decoder7seg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/gcd_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/sub.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/agarwalsahil/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on bricenoandrew Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/cmp.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/decoder7seg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/gcd_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/mux_2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/sub.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/bricenoandrew/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on guigavin Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/comp.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/decoder7seg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/gcd_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/handshake.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/ir_decode_logic.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/jtag_wrapper.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/memory_map.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/sub.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/top_level.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/top_level.vhd.bak}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/user_pkg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/guigavin/vJTAG.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on herrerabryce Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/comp.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrerabryce/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on herrinedwin Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/comp.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/sub.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/herrinedwin/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on lambertchristine Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/comparator.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/subtractor.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/subtractor2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/lambertchristine/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on shelleybradley Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/comparator.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/decoder7seg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/sub.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/shelleybradley/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on sodikromoethan Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/sodikromoethan/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/sodikromoethan/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/sodikromoethan/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/sodikromoethan/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/sodikromoethan/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/sodikromoethan/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on walkersarah Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/comp.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/ctrl1.vhd.bak}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/ctrl2.vhd.bak}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/gcd.vhd.bak}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/sub.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/top_level.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/walkersarah/top_level.vhd.bak}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

onElabError {resume}
onerror {resume}
proc currStudent {lines { message "
Enter 'q' to exit
Enter 'n' for next student
Press Control-C to break out if stuck
Now working on welchaustin Hit Enter to continue ==> "} } {
                puts -nonewline $message
                flush stdout
                set in [gets stdin]
                if {$in == "q"} {
                    quit -f
                    }
                if {$in == "n"} {
                    return
                    }
                for {set i 1} {$i<=2} {incr i} {
                    foreach x $lines {
                    try {
                            eval $x
                        } on error {msg} {
                            puts "FILE COMPILE ERRORS"
                        }
                    } 
                }

try {
    vsim -c work.all_gcd_true_testbench
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}
}

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n" ".vhd " ".vhd\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/comparator.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/ctrl1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/ctrl2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/datapath1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/datapath2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/decoder7seg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/gcd.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/mux2x1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/reg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/subtractor.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab5/welchaustin/top_level.vhd}

quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\ /} $ret]
quietly set lines [split $result "\n"]
currStudent $lines;

exit