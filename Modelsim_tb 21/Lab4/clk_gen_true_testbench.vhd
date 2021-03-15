library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_gen_true_testbench is
end clk_gen_true_testbench;

architecture TB of clk_gen_true_testbench is
    
    signal clk50MHz : std_logic := '0';
    signal rst      : std_logic;
    signal button_n : std_logic;
    signal clk_out  : std_logic;
    signal done     : std_logic := '0';

    constant MS_PERIOD : integer := 2;
    constant MAX_TIME  : time    := (MS_PERIOD+1)*1 ms;  -- allow for time if
                                                         -- button was pressed
                                                         -- between clocks
    constant MIN_TIME  : time    := (MS_PERIOD)*1 ms;    -- the generated clock
                                                         -- should never occur
                                                         -- before MIN_TIME after
                                                         -- the button is pressed

begin  -- TB

    U_CLK_GEN : entity work.clk_gen
        generic map (
            ms_period => MS_PERIOD)
        port map (
            clk50MHz => clk50MHz,
            rst      => rst,
            button_n => button_n,
            clk_out  => clk_out);

    clk50MHz <= not clk50MHz and not done after 10 ns;

    process
        variable before_time, after_time : time;

    begin

        rst      <= '1';
        button_n <= '1';
        wait for 100 ns;

        rst      <= '0';
        button_n <= '0';

        before_time := now;
        wait until clk_out = '1' for MAX_TIME;
        after_time  := now;

        if (clk_out = '0') then
            report "Clock not generated.";
        end if;

        if ((after_time-before_time) < MIN_TIME) then
            report "Clock generated too soon." & time'image(after_time-before_time);
            report "Min time = " & time'image(MIN_TIME);
        end if;

        before_time := now;
        wait until clk_out = '1' for MAX_TIME;
        after_time  := now;

        if (clk_out = '0') then
            report "Clock not generated for continued press.";
        end if;

        if (after_time-before_time < MIN_TIME) then
            report "Clock generated too soon for generated press." & time'image(after_time-before_time);
            report "Min time = " & time'image(MIN_TIME);
        end if;

        wait for 1 ms;

        button_n <= '1';
        wait until clk_out = '1' for 2*MAX_TIME;

        if (clk_out = '1') then
            report "Clock generated when button not pressed.";
        end if;

        button_n    <= '0';
        before_time := now;
        wait until clk_out = '1' for MAX_TIME;
        after_time  := now;

        if (clk_out = '0') then
            report "Clock not generated for pressed button after release.";
        end if;

        if (after_time-before_time < MIN_TIME) then
            report "Clock for pressed button after release generated too soon." & time'image(after_time-before_time);
            report "Min time = " & time'image(MIN_TIME);
        end if;

        report "DONE!";
        done <= '1';
        wait;

    end process;

end TB;
