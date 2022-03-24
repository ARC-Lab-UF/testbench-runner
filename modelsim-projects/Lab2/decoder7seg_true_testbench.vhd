
-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder7seg_true_testbench is  
end decoder7seg_true_testbench;

architecture TB of decoder7seg_true_testbench is


  component decoder7seg
  
    port (
	input  : in  std_logic_vector(3 downto 0);
	output : out std_logic_vector(6 downto 0));
    
  end component;
  
  -- Input
  signal input  : std_logic_vector(3 downto 0);
  
  -- Output
  signal output : std_logic_vector(6 downto 0); 
  
begin  -- TB

  UUT : decoder7seg
    port map (
      input  => input,
      output => output);

  process
  begin

        input    <= "0000";
        wait for 40 ns;
        assert(output = ("0000001")) report "0 failed";
        
        input    <= "0001";
        wait for 40 ns;
        assert(output = ("1001111")) report "1 failed";
        
        input    <= "0010";
        wait for 40 ns;
        assert(output = ("0010010")) report "2 failed";
        
        input    <= "0011";
        wait for 40 ns;
        assert(output = ("0000110")) report "3 failed";
        
        input    <= "0100";
        wait for 40 ns;
        assert(output = ("1001100")) report "4 failed";
        
        input    <= "0101";
        wait for 40 ns;
        assert(output = ("0100100")) report "5 failed";
        
        input    <= "0110";
        wait for 40 ns;
        assert(output = ("0100000")) report "6 failed";
        
        input    <= "0111";
        wait for 40 ns;
        assert(output = ("0001111")) report "7 failed";
        
        input    <= "1000";
        wait for 40 ns;
        assert(output = ("0000000")) report "8 failed";
        
        input    <= "1001";
        wait for 40 ns;
        assert(output = ("0001100")) report "9 failed";
        
        input    <= "1010";
        wait for 40 ns;
        assert(output = ("0001000")) report "A failed";
        
        input    <= "1011";
        wait for 40 ns;
        assert(output = ("1100000")) report "B failed";
        
        input    <= "1100";
        wait for 40 ns;
        assert(output = ("0110001")) report "C failed";
        
        input    <= "1101";
        wait for 40 ns;
        assert(output = ("1000010")) report "D failed";
        
        input    <= "1110";
        wait for 40 ns;
        assert(output = ("0110000")) report "E failed";
        
        input    <= "1111";
        wait for 40 ns;
        assert(output = ("0111000")) report "F failed";
        
        report "SIMLUATION FINISHED!";
        
    wait;
    
  end process;
  

end TB;
