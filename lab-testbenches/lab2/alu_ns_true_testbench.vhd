library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu_ns_true_testbench is
end alu_ns_true_testbench;

architecture TB of alu_ns_true_testbench is

  component alu_ns

    generic (
      WIDTH    :     positive := 16
      );
    port (
      input1   : in  std_logic_vector(WIDTH-1 downto 0);
      input2   : in  std_logic_vector(WIDTH-1 downto 0);
      sel      : in  std_logic_vector(3 downto 0);
      output   : out std_logic_vector(WIDTH-1 downto 0);
      overflow : out std_logic
      );

  end component;

  constant PARTIAL_THRESHOLD : integer := 5;  -- number of errors allowable for
                                              -- partial credit

  -- CHANGE THIS TO 4 FOR THE SECOND TEST  
  constant WIDTH    : positive                           := 8;
  signal   input1   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal   input2   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal   sel      : std_logic_vector(3 downto 0)       := (others => '0');
  signal   output   : std_logic_vector(WIDTH-1 downto 0);
  signal   overflow : std_logic;

begin  -- TB

  UUT : alu_ns
    generic map (WIDTH => WIDTH)
    port map (
      input1           => input1,
      input2           => input2,
      sel              => sel,
      output           => output,
      overflow         => overflow);

  process

    variable temp_add  : std_logic_vector(output'length downto 0);
    variable temp_mult : std_logic_vector(output'length*2-1 downto 0);
    variable temp      : std_logic_vector(output'length-1 downto 0);
    variable temp_sl   : std_logic;
    variable temp_sel  : std_logic_vector(3 downto 0);

    variable add_count, add_overflow_count       : integer := 0;
    variable sub_count, sub_overflow_count       : integer := 0;
    variable mult_count, mult_overflow_count     : integer := 0;
    variable and_count, and_overflow_count       : integer := 0;
    variable or_count, or_overflow_count         : integer := 0;
    variable xor_count, xor_overflow_count       : integer := 0;
    variable nor_count, nor_overflow_count       : integer := 0;
    variable not_count, not_overflow_count       : integer := 0;
    variable shl_count, shl_overflow_count       : integer := 0;
    variable shr_count, shr_overflow_count       : integer := 0;
    variable swap_count, swap_overflow_count     : integer := 0;
    variable brev_count, brev_overflow_count     : integer := 0;
    variable others_count, others_overflow_count : integer := 0;

    variable final_score : integer := 0;

  begin

    report "************Testing Add****************";

    -- test add
    sel <= "0000";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp_add := conv_std_logic_vector(unsigned(input1), input1'length+1) +
                    input2;

        if(output /= temp_add(output'length-1 downto 0)) then
          report "Error : " & integer'image(i) & " + " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp_add(output'length-1 downto 0))) severity warning;

          add_count := add_count + 1;
        end if;


        if (overflow /= temp_add(output'length)) then
          report "Error : overflow of " & integer'image(i) & " + " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of " & std_logic'image(temp_add(output'length)) severity warning;
          add_overflow_count := add_overflow_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i


    report "************Testing Sub****************";

    sel <= "0001";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp := input1-input2;

        if (output /= temp) then
          report "Error : " & integer'image(i) & " - " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp)) severity warning;

          sub_count := sub_count + 1;
        end if;

        if (overflow /= '0') then
          report "Error : overflow of " & integer'image(i) & " - " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of 0" severity warning;

          sub_overflow_count := sub_overflow_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i


    report "************Testing Mult****************";

    sel <= "0010";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp_mult := input1*input2;
        temp_sl   := '1';
        if (temp_mult(output'length*2-1 downto output'length) = 0) then
          temp_sl := '0';
        end if;

        if (output /= temp_mult(output'length-1 downto 0)) then
          report "Error : " & integer'image(i) & " + " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp_mult(output'length-1 downto 0))) severity warning;

          mult_count := mult_count + 1;
        end if;

        if (overflow /= temp_sl) then
          report "Error : overflow of " & integer'image(i) & " + " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of " & std_logic'image(temp_sl) severity warning;

          mult_overflow_count := mult_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i

    report "************Testing And****************";

    sel <= "0011";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp := input1 and input2;

        if (output /= temp) then
          report "Error : " & integer'image(i) & " and " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp)) severity warning;

          and_count := and_count + 1;
        end if;

        if (overflow /= '0') then
          report "Error : overflow of " & integer'image(i) & " or " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of 0" severity warning;

          and_overflow_count := and_overflow_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i

    report "************Testing OR****************";

    sel <= "0100";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp := input1 or input2;

        if (output /= temp) then
          report "Error : " & integer'image(i) & " or " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp)) severity warning;

          or_count := or_count + 1;
        end if;

        if (overflow /= '0') then
          report "Error : overflow of " & integer'image(i) & " or " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of 0" severity warning;

          or_overflow_count := or_overflow_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i

    report "************Testing XOR****************";

    sel <= "0101";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp := input1 xor input2;

        if (output /= temp) then
          report "Error : " & integer'image(i) & " xor " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp)) severity warning;

          xor_count := xor_count + 1;
        end if;

        if (overflow /= '0') then
          report "Error : overflow of " & integer'image(i) & " xor " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of 0" severity warning;

          xor_overflow_count := xor_overflow_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i

    report "************Testing NOR****************";

    sel <= "0110";

    for i in 0 to 2**input1'length-1 loop
      for j in 0 to 2**input2'length-1 loop

        input1 <= conv_std_logic_vector(i, input1'length);
        input2 <= conv_std_logic_vector(j, input2'length);

        wait for 10 ns;
        temp := input1 nor input2;

        if (output /= temp) then
          report "Error : " & integer'image(i) & " nor " &
            integer'image(j) & " is " & integer'image(conv_integer(output)) &
            " instead of " & integer'image(conv_integer(temp)) severity warning;

          nor_count := nor_count + 1;
        end if;

        if (overflow /= '0') then
          report "Error : overflow of " & integer'image(i) & " nor " &
            integer'image(j) & " is " & std_logic'image(overflow) &
            " instead of 0" severity warning;

          nor_overflow_count := nor_overflow_count + 1;
        end if;

      end loop;  -- j      
    end loop;  -- i

    report "************Testing NOT****************";

    sel <= "0111";

    for i in 0 to 2**input1'length-1 loop

      input1 <= conv_std_logic_vector(i, input1'length);

      wait for 10 ns;
      temp := not input1;

      if (output /= temp) then
        report "Error : not " & integer'image(i) &
          " is " & integer'image(conv_integer(output)) &
          " instead of " & integer'image(conv_integer(temp)) severity warning;

        not_count := not_count + 1;
      end if;

      if (overflow /= '0') then
        report "Error : overflow of not " & integer'image(i) &
          " is " & std_logic'image(overflow) &
          " instead of 0" severity warning;

        not_overflow_count := not_overflow_count + 1;
      end if;

    end loop;  -- i

    report "************Testing SHL****************";

    sel <= "1000";

    for i in 0 to 2**input1'length-1 loop

      input1 <= conv_std_logic_vector(i, input1'length);

      wait for 10 ns;
      temp := shl(input1, "1");

      if (output /= temp) then
        report "Error : shl " & integer'image(i) &
          " is " & integer'image(conv_integer(output)) &
          " instead of " & integer'image(conv_integer(temp)) severity warning;

        shl_count := shl_count + 1;
      end if;

      if (overflow /= input1(input1'length-1)) then
        report "Error : overflow of shl " & integer'image(i) &
          " is " & std_logic'image(overflow) &
          " instead of " & std_logic'image(input1(input1'length-1)) severity warning;

        shl_overflow_count := shl_overflow_count + 1;
      end if;

    end loop;  -- i

    report "************Testing SHR****************";

    sel <= "1001";

    for i in 0 to 2**input1'length-1 loop

      input1 <= conv_std_logic_vector(i, input1'length);

      wait for 10 ns;
      temp := shr(input1, "1");

      if (output /= temp) then
        report "Error : shr " & integer'image(i) &
          " is " & integer'image(conv_integer(output)) &
          " instead of " & integer'image(conv_integer(temp)) severity warning;

        shr_count := shr_count + 1;
      end if;

      if (overflow /= '0') then
        report "Error : overflow of shr " & integer'image(i) &
          " is " & std_logic'image(overflow) &
          " instead of 0" severity warning;

        shr_overflow_count := shr_overflow_count + 1;
      end if;

    end loop;  -- i

    report "************Testing SWAP****************";

    sel <= "1010";

    for i in 0 to 2**input1'length-1 loop

      input1 <= conv_std_logic_vector(i, input1'length);

      wait for 10 ns;
      temp := input1(input1'length/2-1 downto 0) & input1(input1'length-1 downto input1'length/2);

      if (output /= temp) then
        report "Error : swap " & integer'image(i) &
          " is " & integer'image(conv_integer(output)) &
          " instead of " & integer'image(conv_integer(temp)) severity warning;

        swap_count := swap_count + 1;
      end if;

      if (overflow /= '0') then
        report "Error : overflow of swap " & integer'image(i) &
          " is " & std_logic'image(overflow) &
          " instead of 0" severity warning;

        swap_overflow_count := swap_overflow_count + 1;
      end if;

    end loop;  -- i

    report "************Testing BREV****************";

    sel <= "1011";

    for i in 0 to 2**input1'length-1 loop

      input1 <= conv_std_logic_vector(i, input1'length);

      wait for 10 ns;
      for i in 0 to input1'length-1 loop
        temp(i) := input1(input1'length-1-i);
      end loop;

      if (output /= temp) then
        report "Error : brev " & integer'image(i) &
          " is " & integer'image(conv_integer(output)) &
          " instead of " & integer'image(conv_integer(temp)) severity warning;

        brev_count := brev_count + 1;
      end if;

      if (overflow /= '0') then
        report "Error : overflow of brev " & integer'image(i) &
          " is " & std_logic'image(overflow) &
          " instead of 0" severity warning;

        brev_overflow_count := brev_overflow_count + 1;
      end if;

    end loop;  -- i

    report "************Testing OTHERS****************";

    temp_sel := "1100";

    while (temp_sel /= 0) loop

      sel <= temp_sel;
      wait for 10 ns;
      if (output /= 0) then
        report "Error : incorrect output for sel " & integer'image(conv_integer(sel)) severity warning;

        others_count := others_count + 1;
      end if;

      if (overflow /= '0') then
        report "Error : incorrect overflow for sel " & integer'image(conv_integer(sel)) severity warning;

        others_overflow_count := others_overflow_count + 1;
      end if;

      temp_sel := temp_sel + 1;

    end loop;


    report "*************DONE TESTING******************";
    report "SUMMARY : ";
    report "Add fails = " & integer'image(add_count);
    report "Add overflow fails = " & integer'image(add_overflow_count);

    report "Sub fails = " & integer'image(sub_count);
    report "Sub overflow fails = " & integer'image(sub_overflow_count);

    report "Mult fails = " & integer'image(mult_count);
    report "Mult overflow fails = " & integer'image(mult_overflow_count);

    report "And fails = " & integer'image(and_count);
    report "And overflow fails = " & integer'image(and_overflow_count);

    report "Or fails = " & integer'image(or_count);
    report "Or overflow fails = " & integer'image(or_overflow_count);

    report "Xor fails = " & integer'image(xor_count);
    report "Xor overflow fails = " & integer'image(xor_overflow_count);

    report "Nor fails = " & integer'image(nor_count);
    report "Nor overflow fails = " & integer'image(nor_overflow_count);

    report "Not fails = " & integer'image(not_count);
    report "Not overflow fails = " & integer'image(not_overflow_count);

    report "Shl fails = " & integer'image(shl_count);
    report "Shl overflow fails = " & integer'image(shl_overflow_count);

    report "Shr fails = " & integer'image(shr_count);
    report "Shr overflow fails = " & integer'image(shr_overflow_count);

    report "Swap fails = " & integer'image(swap_count);
    report "Swap overflow fails = " & integer'image(swap_overflow_count);

    report "Brev fails = " & integer'image(brev_count);
    report "Brev overflow fails = " & integer'image(brev_overflow_count);

    report "Other fails = " & integer'image(others_count);
    report "Other overflow fails = " & integer'image(others_overflow_count);

    final_score := 0;

    if (add_count + add_overflow_count = 0) then
      final_score := final_score + 15;
    elsif (add_count + add_overflow_count < PARTIAL_THRESHOLD) then
      final_score := final_score + 10;
    end if;

    if (sub_count + sub_overflow_count = 0) then
      final_score := final_score + 10;
    elsif (sub_count + sub_overflow_count < PARTIAL_THRESHOLD) then
      final_score := final_score + 5;
    end if;

    if (mult_count + mult_overflow_count = 0) then
      final_score := final_score + 15;
    elsif (mult_count + mult_overflow_count < PARTIAL_THRESHOLD) then
      final_score := final_score + 10;
    end if;

    if (and_count + and_overflow_count = 0) then
      final_score := final_score + 4;
    end if;

    if (or_count + or_overflow_count = 0) then
      final_score := final_score + 4;
    end if;

    if (xor_count + xor_overflow_count = 0) then
      final_score := final_score + 4;
    end if;

    if (nor_count + nor_overflow_count = 0) then
      final_score := final_score + 4;
    end if;

    if (not_count + not_overflow_count = 0) then
      final_score := final_score + 4;
    end if;

    if (shl_count + shl_overflow_count = 0) then
      final_score := final_score + 10;
    elsif (shl_count + shl_overflow_count < PARTIAL_THRESHOLD) then
      final_score := final_score + 5;
    end if;

    if (shr_count + shr_overflow_count = 0) then
      final_score := final_score + 5;
    end if;

    if (swap_count + swap_overflow_count = 0) then
      final_score := final_score + 10;
    elsif (swap_count + swap_overflow_count < PARTIAL_THRESHOLD) then
      final_score := final_score + 5;
    end if;

    if (brev_count + brev_overflow_count = 0) then
      final_score := final_score + 15;
    elsif (brev_count + brev_overflow_count < PARTIAL_THRESHOLD) then
      final_score := final_score + 10;
    end if;

    final_score := final_score / 2;

    report "FINAL SCORE = " & integer'image(final_score);

    wait;

  end process;



end TB;
