project open {C:\Users\keeth\Desktop\TA folder\Spring 21\Tester 21\Lab4\Lab4.mpf}

proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on agarwalsahil Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/agarwalsahil/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on bricenoandrew Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/bricenoandrew/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on guigavin Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/clk_div_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/clk_gen_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/guigavin/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on herrerabryce Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/clk_div_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/clk_gen_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/gray2_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrerabryce/top_level.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on herrinedwin Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/herrinedwin/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on lambertchristine Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/lambertchristine/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on shelleybradley Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/clk_div_TB.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/clk_gen_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/decoder7seg.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/gray2_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/shelleybradley/top_level.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on sodikromoethan Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/clk_div_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/clk_gen_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/sodikromoethan/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on walkersarah Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/walkersarah/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






proc currStudent {{ message "
Enter 'q' to exit
Press Control-C to break out if stuck
Now working on welchaustin Hit Enter to continue ==> "}} {
                puts -nonewline $message
                set in [read stdin 1]
                if {$in == "q"} {
                    quit -f
                    }
            }

 
quietly set result [string map -nocase {"\} \{" "\}\n\{" "\} " "\}\n"} [project filenames]] 
quietly set lines [split $result "\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/clk_div.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/clk_div_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/clk_gen.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/clk_gen_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/counter.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/counter_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/gray1.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/gray1_tb.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/gray2.vhd}
project addfile {C:/Users/keeth/Desktop/TA folder/Spring 21/Wednesday(11987)/Submissions/Lab4/welchaustin/gray2_tb.vhd}

currStudent;

proc pause {{message "\nHit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


try {
    vsim -c work.true_clk_gen_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause;

try {
    vsim -c work.true_gray_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}

pause; 


try {
    vsim -c work.true_counter_tb
    add wave *
    run -all
} on error {msg} {
    puts "SIMULATION FAILED"
    puts $msg
    quit -sim
}






