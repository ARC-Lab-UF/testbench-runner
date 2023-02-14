-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_true_testbench is  
end fa_true_testbench;

architecture TB of fa_true_testbench is

  signal input1, input2, carry_in, sum, carry_out : std_logic;
  
begin  -- TB

  UUT : entity work.fa
    port map (
      input1    => input1,
      input2    => input2,
      carry_in  => carry_in,
      sum       => sum,
      carry_out => carry_out);

  process
    variable temp : std_logic_vector(2 downto 0);
  begin

    for i in 0 to 7 loop
      temp := std_logic_vector(to_unsigned(i,3));
      input1 <= temp(2);
      input2 <= temp(1);
      carry_in <= temp(0);
	  wait for 40 ns;
      assert(sum = (input1 xor input2 xor carry_in)) report "Sum failed";
      assert(carry_out = ((input1 and input2) or (input1 and carry_in) or (input2 and carry_in))) report "Carry failed";
            
    end loop;  -- i

    report "SIMLUATION FINISHED!";
    wait;
    
  end process;
  

end TB;
