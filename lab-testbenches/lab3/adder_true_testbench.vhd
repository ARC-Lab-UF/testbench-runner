-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_true_testbench is
end adder_true_testbench;


architecture TB of adder_true_testbench is

    component adder
        generic (
            WIDTH : positive := 8);
        port (
            x, y : in  std_logic_vector(WIDTH-1 downto 0);
            carry_in  : in  std_logic;
            s    : out std_logic_vector(WIDTH-1 downto 0);
            carry_out : out std_logic);
    end component;

    constant TEST_WIDTH  : positive := 8;
    constant TEST_WIDTH2 : positive := 4;

    signal x, y              : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal x2, y2            : std_logic_vector(TEST_WIDTH2-1 downto 0);
    signal cin               : std_logic;
    signal s_rc              : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal s_rc2             : std_logic_vector(TEST_WIDTH2-1 downto 0);
    signal s_cl              : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal s_cl2             : std_logic_vector(TEST_WIDTH2-1 downto 0);
    signal s_h               : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal cout_rc, cout_rc2 : std_logic;
    signal cout_cl, cout_cl2 : std_logic;
    signal cout_h, cout_h2   : std_logic;

begin  -- TB

    U_RIPPLE_CARRY1 : adder
        generic map (
            WIDTH => TEST_WIDTH)
        port map (
            x    => x,
            y    => y,
            carry_in  => cin,
            s    => s_rc,
            carry_out => cout_rc);

    U_RIPPLE_CARRY2 : adder
        generic map (
            WIDTH => TEST_WIDTH2)
        port map (
            x    => x2,
            y    => y2,
            carry_in  => cin,
            s    => s_rc2,
            carry_out => cout_rc2);

    U_CARRY_LOOKAHEAD1 : adder
        generic map (
            WIDTH => TEST_WIDTH)
        port map (
            x    => x,
            y    => y,
            carry_in  => cin,
            s    => s_cl,
            carry_out => cout_cl);

    U_CARRY_LOOKAHEAD2 : adder
        generic map (
            WIDTH => TEST_WIDTH2)
        port map (
            x    => x2,
            y    => y2,
            carry_in  => cin,
            s    => s_cl2,
            carry_out => cout_cl2);

    U_HIERARCHICAL : adder
        generic map (
            WIDTH => 8)                 -- this architecture ignores the
                                        -- generic, fixed to size 8
        port map (
            x    => x,
            y    => y,
            carry_in  => cin,
            s    => s_h,
            carry_out => cout_h);

    process
        variable error_rc        : integer;
        variable error_cl        : integer;
        variable error_h         : integer;
        variable result_tmp      : unsigned(TEST_WIDTH downto 0);
        variable result_tmp2     : unsigned(TEST_WIDTH2 downto 0);
        variable correct_result  : std_logic_vector(TEST_WIDTH-1 downto 0);
        variable correct_result2 : std_logic_vector(TEST_WIDTH2-1 downto 0);
        variable correct_cout    : std_logic;

        variable score_rc  : integer;
        variable score_cla : integer;
        variable score_h   : integer;
        
    begin

        error_rc := 0;
        error_cl := 0;
        error_h  := 0;

        report "******************TESTING WIDTH = 8********************";

        for i in 0 to TEST_WIDTH-1 loop

            x <= std_logic_vector(to_unsigned(i, TEST_WIDTH));

            for j in 0 to TEST_WIDTH-1 loop

                y <= std_logic_vector(to_unsigned(j, TEST_WIDTH));

                for k in 0 to 1 loop

                    cin <= std_logic(to_unsigned(k, 1)(0));

                    wait for 10 ns;

                    result_tmp     := unsigned("0"&x) + unsigned("0"&y) + to_unsigned(k, 1);
                    correct_result := std_logic_vector(result_tmp(TEST_WIDTH-1 downto 0));
                    correct_cout   := std_logic(result_tmp(TEST_WIDTH));

                    if (s_rc /= correct_result) then
                        error_rc := error_rc + 1;
                        report "Error : RC, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_rc))) severity warning;
                    end if;
                    if (cout_rc /= correct_cout) then
                        error_rc := error_rc + 1;
                        report "Error : RC, carry from " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & std_logic'image(cout_rc) severity warning;
                    end if;

                    if (s_cl /= correct_result) then
                        error_cl := error_cl + 1;
                        report "Error : CL, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_cl))) severity warning;
                    end if;
                    if (cout_cl /= correct_cout) then
                        error_cl := error_cl + 1;
                        report "Error : CL, carry from " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & std_logic'image(cout_cl) severity warning;
                    end if;

                    if (s_h /= correct_result) then
                        error_h := error_h + 1;
                        report "Error : HEIR, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_h))) severity warning;
                    end if;
                    if (cout_h /= correct_cout) then
                        error_h := error_h + 1;
                        report "Error : HEIR, carry from " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & std_logic'image(cout_h) severity warning;
                    end if;

                end loop;  -- k
            end loop;  -- j      
        end loop;  -- i

        report "******************TESTING WIDTH = 4********************";

        -- Test a different width

        for i in 0 to TEST_WIDTH2-1 loop
            x2 <= std_logic_vector(to_unsigned(i, TEST_WIDTH2));

            for j in 0 to TEST_WIDTH2-1 loop

                y2 <= std_logic_vector(to_unsigned(j, TEST_WIDTH2));

                for k in 0 to 1 loop

                    cin <= std_logic(to_unsigned(k, 1)(0));

                    wait for 10 ns;
                    result_tmp2     := unsigned("0"&x2) + unsigned("0"&y2) + to_unsigned(k, 1);
                    correct_result2 := std_logic_vector(result_tmp2(TEST_WIDTH2-1 downto 0));
                    correct_cout    := std_logic(result_tmp2(TEST_WIDTH2));

                    if (s_rc2 /= correct_result2) then
                        error_rc := error_rc + 1;
                        report "Error : RC, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_rc2))) severity warning;
                    end if;
                    if (cout_rc2 /= correct_cout) then
                        error_rc := error_rc + 1;
                        report "Error : RC, carry from " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & std_logic'image(cout_rc2) severity warning;
                    end if;

                    if (s_cl2 /= correct_result2) then
                        error_cl := error_cl + 1;
                        report "Error : CL, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_cl2))) severity warning;
                    end if;
                    if (cout_cl2 /= correct_cout) then
                        error_cl := error_cl + 1;
                        report "Error : CL, carry from " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & std_logic'image(cout_cl2) severity warning;
                    end if;

                end loop;  -- k
            end loop;  -- j      
        end loop;  -- i

        report "Ripple carry errors    : " & integer'image(error_rc);
        report "Carry lookahead errors : " & integer'image(error_cl);
        report "Heirarchical errors    : " & integer'image(error_h);

        score_rc  := 20 - error_rc;
        score_cla := 30 - error_cl;
        score_h   := 50 - error_h;

        if score_rc < 0 then
            score_rc := 0;
        end if;

        if score_cla < 0 then
            score_cla := 0;
        end if;

        if score_h < 0 then
            score_h := 0;
        end if;

        report "RIPPLE_CARRY SCORE = " & integer'image(score_rc);
        report "CLA SCORE = " & integer'image(score_cla);
        report "HEIRARCHICAL SCORE = " & integer'image(score_h);

        wait;

    end process;

end TB;


configuration adder_true_testbench_config of adder_true_testbench is
    for TB
        for U_RIPPLE_CARRY1 : adder
            use entity work.adder(RIPPLE_CARRY);
        end for;
        for U_RIPPLE_CARRY2 : adder
            use entity work.adder(RIPPLE_CARRY);
        end for;
        for U_CARRY_LOOKAHEAD1 : adder
            use entity work.adder(CARRY_LOOKAHEAD);
        end for;
        for U_CARRY_LOOKAHEAD2 : adder
            use entity work.adder(CARRY_LOOKAHEAD);
        end for;
        for U_HIERARCHICAL : adder
            use entity work.adder(HIERARCHICAL);
        end for;
    end for;

end adder_true_testbench_config;
