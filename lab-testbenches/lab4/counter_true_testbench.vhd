
-- Jovanny Vera


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter_true_testbench is
end counter_true_testbench;


architecture TB of counter_true_testbench is
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal up_n     : std_logic := '1';
	 signal load_n   : std_logic := '1';
    signal output : std_logic_vector(3 downto 0);
    signal input : std_logic_vector(3 downto 0);
    signal done : std_logic := '0';    
    
begin


    UUT : entity work.counter
        port map (
            clk    => clk,
            rst    => rst,
            up_n   => up_n,
			load_n => load_n,
            output => output,
			input  => input 
			);

    -- create the clock (and not done ensure that the simulation will finish)
    clk <= not clk and not done after 25 ns;
  
    process
    begin
        -- reset the counter for 4 cycles
	input <= "1010";
        rst <= '1';
		up_n <= '0';
        for i in 0 to 3 loop
            wait until rising_edge(clk);
        end loop;

        rst <= '0';
        wait until rising_edge(clk);
		--test load	
		  load_n <= '0';	
        wait until rising_edge(clk);
        wait until rising_edge(clk);
		 assert(output = "1010") report "Error : load 10 = " & integer'image(to_integer(unsigned(output))) & " instead of 10" severity warning;	  
		 load_n <= '1';
		--wait 4 cycles of not going
        for i in 0 to 3 loop
            wait until rising_edge(clk);
        end loop;	 
		
		rst <= '1';
            wait until rising_edge(clk);
        rst <= '0';
    --    wait until rising_edge(clk);

		--test count up and overflow
		for I in 0 to 31 loop
			if(to_integer(unsigned(output)) /= I mod 16) then
				 report "Error counter = " & integer'image(to_integer(unsigned(output))) & " instead of " & integer'image(I mod 16) & " on count up" severity warning;			
			end if;
						
			wait until rising_edge(clk);
			wait for 1 ns;

		end loop;			
		--reset
		rst <= '1';
            wait until rising_edge(clk);
        rst <= '0';		
		up_n <= '1';
        wait until output = "1111";

		--test count down and underflow
		for I in 0 to 31 loop		
			if(to_integer(unsigned(output)) /= ((31 - I) mod 16)) then
				 report "Error counter = " & integer'image(to_integer(unsigned(output))) & " instead of " & integer'image(((31 - I) mod 16)) & " on count down" severity warning;			
			end if;
			wait until rising_edge(clk);
			wait for 1 ns;
		end loop;	




  		done <= '1';
		report "DONE!";             
    end process;
    
    
end TB;
