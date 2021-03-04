import os




def tcl_function(tclFile, project_mpf, resultList):

    with open(os.path.abspath(tclFile), "r") as f:
        tclScript = f.read()
    

    tcl = 'project open {' + f'{os.path.abspath(project_mpf)}' + '}\n\n'

    for x in resultList:
        tcl += '''onElabError {resume}\nonerror {resume}\nproc currStudent {lines { '''
    
        tcl += f'''message "\nEnter 'q' to exit\nEnter 'n' for next student\nPress Control-C to break out if stuck\nNow working on {x[1]} '''

        tcl += '''Hit Enter to continue ==> "} } {
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
'''
        tcl += tclScript + '''\n}\n\n'''

            
        tcl += ''' 
quietly set result [string map -nocase {"\} \{" "\}\\n\{" "\} " "\}\\n" ".vhd " ".vhd\\n"} [project filenames]] 
quietly set lines [split $result "\\n"]

foreach x $lines {
   if {[string match *true_testbench.vhd* $x] == 1} {
      set z 1
   } else {
    #   puts "REMOVED"
      eval project removefile $x
   }
} 

'''
        tcl += x[0]
        tcl += '''
quietly set ret [project compileall -n]
quietly set result [string map {explicit quiet \\\ /} $ret]
quietly set lines [split $result "\\n"]'''
        tcl += '''\ncurrStudent $lines;\n\n'''


    tcl += 'exit'

    return tcl