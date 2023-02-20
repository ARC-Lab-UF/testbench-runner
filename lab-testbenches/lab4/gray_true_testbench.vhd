library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray_true_testbench is
end gray_true_testbench;


architecture TB of gray_true_testbench is 
	     signal clk    : std_logic := '0';
        signal rst    : std_logic;
        signal output1 : std_logic_vector(3 downto 0);
        signal output2 : std_logic_vector(3 downto 0);
		signal done     : std_logic := '0';

		type greys is array (0 to 15) of std_logic_vector(3 downto 0);
		constant grey_results : greys := ("0000", "0001", "0011","0010","0110",
		"0111", "0101", "0100", "1100", "1101","1111", "1110", "1010", "1011",
		"1001", "1000");
begin
	    U_GRAY1 : entity work.gray1
        port map (
            clk => clk,
            rst      => rst,
            output  => output1);


	    U_GRAY2 : entity work.gray2
        port map (
            clk => clk,
            rst      => rst,
            output  => output2);
	
	clk <= not clk and not done after 25 ns ;
	process
	begin
	   rst   <= '1';
	   wait for 100 ns;
	   rst  <= '0';		
		wait until output2 = "0001";
	
		for I in 1 to 15 loop
			if(output2 /= grey_results(I)) then
				 report "Error gray2 = " & integer'image(to_integer(unsigned(output2))) & " instead of " & integer'image(to_integer(unsigned(grey_results(I)))) severity warning;			
			end if;
			
			if(output1 /= grey_results(I-1)) then
				 report "Error gray1 = " & integer'image(to_integer(unsigned(output1))) & " instead of " & integer'image(to_integer(unsigned(grey_results(I-1)))) severity warning;			
			end if;
			
			wait until clk = '1';
			wait for 1 ns;
		end loop;
		--check gray2 overflow
		if(output2 /= "0000") then
			report "Error gray2 overflow failed " severity warning;			
		end if;	
		--wait one cycle and check grey1
		wait until clk = '1';
		wait for 1 ns;

		--check gray1 overflow
		if(output1 /= "0000") then
			report "Error gray1 overflow failed " severity warning;			
		end if;	

		done <= '1';
		report "DONE!";
	end process;			
end TB;