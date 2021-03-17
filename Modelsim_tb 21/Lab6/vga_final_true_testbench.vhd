library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

use ieee.std_logic_textio.all;
use std.textio.all;

entity vga_final_true_testbench is
end vga_final_true_testbench;

architecture TB of vga_final_true_testbench is

    component top_level is
        port (
            clk              : in std_logic;
            switch           : in std_logic_vector(9 downto 0);
            button           : in std_logic_vector(1 downto 0);
            red, green, blue : out std_logic_vector(3 downto 0);
            h_sync, v_sync   : out std_logic
        );
    end component;

    component VGA_sync_gen is
        port (
            clk            : in std_logic;
            rst            : in std_logic;
            h_sync, v_sync : out std_logic;
            video_on       : out std_logic;

            -- Can be either std_logic_vector or unsigned
            -- depending on your implementation
            -- h_count, v_count : out unsigned(9 downto 0);
            h_count, v_count : out unsigned(9 downto 0));

    end component;

    constant TIMEOUT : time := 1 ms;

    signal clkEn            : std_logic := '1';
    signal clk              : std_logic := '0';
    signal pixel_clock      : std_logic := '0';
    signal switch           : std_logic_vector(9 downto 0);
    signal button           : std_logic_vector(1 downto 0);
    signal red, green, blue : std_logic_vector(3 downto 0);
    signal rst, video_On    : std_logic;
    signal h_sync, v_sync   : std_logic;

begin -- TB

    -- Optional pixel_clk signal included depending on implementation
    clk         <= not clk and clkEn after 10 ns;
    pixel_clock <= not pixel_clock and clkEn after 20 ns;

    TOP_LVL : top_level port map(
        clk    => clk,
        switch => switch,
        button => button,
        red    => red,
        green  => green,
        blue   => blue,
        h_sync => h_sync,
        v_sync => v_sync);

    -- Current implementation assumes a divider already inside sync_gen
    Sync_Gen : VGA_sync_gen port map(
        clk      => clk,
        rst      => rst,
        h_sync   => open,
        v_sync   => open,
        video_On => video_On,
        h_count  => open,
        v_count  => open);

    process
        variable ideal  : time;
        variable start  : time;
        variable stop   : time;
        variable width  : time;
        variable errors : integer := 0;

        variable width_p : time;
        variable width_q : time;
        variable width_r : time;
        variable width_s : time;
        variable percent : integer := 0;
    begin

        --------------------------------------------------------------------------------
                                    -- Begin Timing Measurements
        --------------------------------------------------------------------------------
        -- (not) button 0 connected to reset in this implementation
        rst    <= '1';
        button <= (others => '0');
        switch <= (others => '0');
        wait for 20 ns;
        rst    <= '0';
        button <= (others => '1');

        ------------------------------
                -- MEASURE A --
        ------------------------------
                -- A = 31.77 us
        ideal := 31.77 us;
        wait until falling_edge(h_sync) for 10 * TIMEOUT;
        start := now;
        wait until falling_edge(h_sync) for (10 * ideal);
        stop  := now;
        width := (stop - start);

        assert(width  > 0.8 * ideal) report "A distance too short" & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert(width  < 1.2 * ideal) report "A distance too long " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert((width > 0.8 * ideal) and (width < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width < 0.8 * ideal) or (width > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE B --
        ------------------------------
                -- B = 3.77 us
        ideal := 3.77 us;
        start := now;
        wait until rising_edge(h_sync) for (10 * ideal);
        stop  := now;
        width := (stop - start);

        assert(width  > 0.8 * ideal) report "B distance too short" & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert(width  < 1.2 * ideal) report "B distance too long " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert((width > 0.8 * ideal) and (width < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width < 0.8 * ideal) or (width > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE C --
        ------------------------------
                -- C = 1.89 us
        ideal := 1.89 us;
        start := now;
        wait until rising_edge(video_On) for (10 * ideal);
        stop  := now;
        width := (stop - start);

        assert(width  > 0.8 * ideal) report "C distance too short: " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert(width  < 1.2 * ideal) report "C distance too long:  " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert((width > 0.8 * ideal) and (width < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width < 0.8 * ideal) or (width > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE D --
        ------------------------------
                -- D = 25.17 us
        ideal := 25.17 us;
        start := now;
        wait until falling_edge(video_On) for (10 * ideal);
        stop  := now;
        width := (stop - start);

        assert(width  > 0.8 * ideal) report "D distance too short: " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert(width  < 1.2 * ideal) report "D distance too long:  " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert((width > 0.8 * ideal) and (width < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width < 0.8 * ideal) or (width > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE E --
        ------------------------------
                -- E = 0.94 us
        ideal := 0.94 us;
        start := now;
        wait until falling_edge(h_sync) for (10 * ideal);
        stop  := now;
        width := (stop - start);

        assert(width  > 0.8 * ideal) report "E distance too short: " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert(width  < 1.2 * ideal) report "E distance too long:  " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert((width > 0.8 * ideal) and (width < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width < 0.8 * ideal) or (width > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE P --
        ------------------------------
                -- P = 64 us
        ideal := 64 us;
        wait until falling_edge(v_sync) for (100 * TIMEOUT);
        start := now;
        wait until rising_edge(v_sync) for (10 * ideal);
        stop    := now;
        width_p := (stop - start);

        assert(width_p  > 0.8 * ideal) report "P distance too short: " & time'image(width_p) & ". Expected: " & time'image(ideal) severity warning;
        assert(width_p  < 1.2 * ideal) report "P distance too long:  " & time'image(width_p) & ". Expected: " & time'image(ideal) severity warning;
        assert((width_p > 0.8 * ideal) and (width_p < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width_p < 0.8 * ideal) or (width_p > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE Q --
        ------------------------------
                -- Q = 1.02 ms
        ideal := 1.02 ms;
        start := now;
        wait until rising_edge(video_On) for (10 * ideal);
        stop    := now;
        width_q := (stop - start);

        assert(width_q  > 0.8 * ideal) report "Q distance too short: " & time'image(width_q) & ". Expected: " & time'image(ideal) severity warning;
        assert(width_q  < 1.2 * ideal) report "Q distance too long:  " & time'image(width_q) & ". Expected: " & time'image(ideal) severity warning;
        assert((width_q > 0.8 * ideal) and (width_q < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width_q < 0.8 * ideal) or (width_q > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE R --
        ------------------------------
                -- R = 15.25 ms
        ideal := 15.25 ms;
        start := now;
        for i in 0 to 479 loop
            wait until falling_edge(video_On) for (ideal/48);
        end loop;
        stop    := now;
        width_r := (stop - start);

        assert(width_r  > 0.8 * ideal) report "R distance too short: " & time'image(width_r) & ". Expected: " & time'image(ideal) severity warning;
        assert(width_r  < 1.2 * ideal) report "R distance too long:  " & time'image(width_r) & ". Expected: " & time'image(ideal) severity warning;
        assert((width_r > 0.8 * ideal) and (width_r < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width_r < 0.8 * ideal) or (width_r > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE S --
        ------------------------------
                -- S = 0.35 ms
        ideal := 0.35 ms;
        start := now;
        wait until falling_edge(v_sync) for (10 * ideal);
        stop    := now;
        width_s := (stop - start);

        assert(width_s  > 0.8 * ideal) report "S distance too short: " & time'image(width_s) & ". Expected: " & time'image(ideal) severity warning;
        assert(width_s  < 1.2 * ideal) report "S distance too long:  " & time'image(width_s) & ". Expected: " & time'image(ideal) severity warning;
        assert((width_s > 0.8 * ideal) and (width_s < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width_s < 0.8 * ideal) or (width_s > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        ------------------------------
                -- MEASURE O --
        ------------------------------
                -- O = 16.6 ms
        ideal := 16.6 ms;
        width := width_p + width_q + width_r + width_s;

        assert(width  > 0.8 * ideal) report "O distance too short: " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert(width  < 1.2 * ideal) report "O distance too long:  " & time'image(width) & ". Expected: " & time'image(ideal) severity warning;
        assert((width > 0.8 * ideal) and (width < 1.2 * ideal)) report time'image(start) & " -- " & time'image(stop);

        if ((width < 0.8 * ideal) or (width > 1.2 * ideal)) then
            errors := errors + 1;
        end if;

        --------------------------------------------------------------------------------
                                -- Begin Positioning Measurements
        --------------------------------------------------------------------------------

        -- Select lines are controlled by switches 2-0 as shown
        -- Reset is controlled by (not) button 0
        -- If you have different architecture feel free to change
        -- the tb to match you're architecture

        -- top left
        wait for 20 ns;
        switch <= "0000000001";

        wait until falling_edge(v_sync) for (100 * TIMEOUT);
        wait until rising_edge(v_sync)  for (10  * ideal);

        -- top right
        wait for 20 ns;
        switch <= "0000000010";

        wait until falling_edge(v_sync) for (100 * TIMEOUT);
        wait until rising_edge(v_sync)  for (10  * ideal);

        -- bottom left
        wait for 20 ns;
        switch <= "0000000011";

        wait until falling_edge(v_sync) for (100 * TIMEOUT);
        wait until rising_edge(v_sync)  for (10  * ideal);

        -- bottom right
        wait for 20 ns;
        switch <= "0000000100";

        wait until falling_edge(v_sync) for (100 * TIMEOUT);

        clkEn <= '0';

        report "DONE!!!!!!" severity note;

        if errors <= 10 then
            percent := 50-errors*5;
        else
            percent := 0;
        end if;
        report "VGA Sync Score = " & integer'image(percent) & "/50" severity note;

        wait;

    end process;

    -- Saves "vga_output.txt" inside the modelsim folder
    -- Upload at https://ericeastwood.com/lab/vga-simulator/
    -- Works with chrome, don't know about other browsers
    -- Should show one picture in each position

    process (pixel_clock)
        file file_pointer : text is out "vga_output.txt";
        variable line_el  : line;
    begin

        if rising_edge(pixel_clock) then

            -- Write the time
            write(line_el, now);          -- write the line.
            write(line_el, string'(":")); -- write the line.

            -- Write the hsync
            write(line_el, string'(" "));
            write(line_el, h_sync); -- write the line.

            -- Write the vsync
            write(line_el, string'(" "));
            write(line_el, v_sync); -- write the line.

            -- Write the red
            write(line_el, string'(" "));
            write(line_el, red); -- write the line.

            -- Write the green
            write(line_el, string'(" "));
            write(line_el, green); -- write the line.

            -- Write the blue
            write(line_el, string'(" "));
            write(line_el, blue); -- write the line.

            writeline(file_pointer, line_el); -- write the contents into the file.

        end if;
    end process;
end TB;