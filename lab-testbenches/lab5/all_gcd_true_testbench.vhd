library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity all_gcd_true_testbench is
end all_gcd_true_testbench;

architecture TB of all_gcd_true_testbench is

  component gcd
    generic (
      WIDTH  :     positive := 16);
    port (
      clk    : in  std_logic;
      rst    : in  std_logic;
      go     : in  std_logic;
      done   : out std_logic;
      x      : in  std_logic_vector(WIDTH-1 downto 0);
      y      : in  std_logic_vector(WIDTH-1 downto 0);
      output : out std_logic_vector(WIDTH-1 downto 0));
  end component;

  constant WIDTH   : positive := 4;
  constant TIMEOUT : time     := 1 ms;

  signal clkEn  : std_logic := '1';
  signal clk    : std_logic := '0';
  signal rst    : std_logic := '1';
  signal go     : std_logic := '0';
  signal done,done1,done2   : std_logic;
  signal x      : std_logic_vector(WIDTH-1 downto 0);
  signal y      : std_logic_vector(WIDTH-1 downto 0);
  signal output,output1,output2 : std_logic_vector(WIDTH-1 downto 0);

begin

  FSMD : entity work.gcd(FSMD)
    generic map (
      WIDTH  => WIDTH)
    port map (
      clk    => clk,
      rst    => rst,
      go     => go,
      done   => done,
      x      => x,
      y      => y,
      output => output);
		
  FSM_D1 : entity work.gcd(FSM_D1)
    generic map (
      WIDTH  => WIDTH)
    port map (
      clk    => clk,
      rst    => rst,
      go     => go,
      done   => done1,
      x      => x,
      y      => y,
      output => output1);
		
  FSM_D2 : entity work.gcd(FSM_D2)
    generic map (
      WIDTH  => WIDTH)
    port map (
      clk    => clk,
      rst    => rst,
      go     => go,
      done   => done2,
      x      => x,
      y      => y,
      output => output2);

  clk <= not clk and clkEn after 20 ns;

  process

    function GCD (x, y : integer)
      return std_logic_vector is

      variable tmpX, tmpY : integer;
    begin

      tmpX     := x;
      tmpY     := y;
      while (tmpX /= tmpY) loop
        if tmpX < tmpY then
          tmpY := tmpY-tmpX;
        else
          tmpX := tmpX-tmpY;
        end if;
      end loop;

      return std_logic_vector(to_unsigned(tmpX, WIDTH));

    end GCD;

    variable errors,errors1,errors2  : integer := 0;
    variable percent,percent1,percent2 : integer := 0;
    variable result  : std_logic_vector(WIDTH-1 downto 0);

  begin

    clkEn <= '1';
    rst   <= '1';
    go    <= '0';
    x     <= std_logic_vector(to_unsigned(0, WIDTH));
    y     <= std_logic_vector(to_unsigned(0, WIDTH));
    wait for 200 ns;

    rst <= '0';
    for i in 0 to 5 loop
      wait until clk'event and clk = '1';
    end loop;  -- i

    for i in 1 to 2**WIDTH-1 loop

      x <= std_logic_vector(to_unsigned(i, WIDTH));

      for j in 1 to 2**WIDTH-1 loop

        go <= '1';
        y  <= std_logic_vector(to_unsigned(j, WIDTH));
		  --FSMD
		  --*****************  
		  --*****************
        wait until done = '1' for TIMEOUT;
        assert(done = '1') report "FSMD Done never asserted." severity warning;
        result := GCD(i, j);
        assert(output = result) report "Incorrect FSMD GCD" severity warning;


        if done = '0' then
          errors := errors + 1;
        elsif output /= result then
          errors := errors + 1;
        end if;
		  --FSMD_1
		  --*****************  
		  --*****************
		  wait until done1 = '1' for TIMEOUT;
        assert(done1 = '1') report "FSMD_1 Done never asserted." severity warning;
		  assert(output1 = result) report "Incorrect FSM_D1 GCD" severity warning;	 
		 
		 
		   if done1 = '0' then
          errors1 := errors1 + 1;
        elsif output1 /= result then
          errors1 := errors1 + 1;
        end if;
	    --FSMD_2	
		 --*****************    
		 --*****************
		  wait until done2 = '1' for TIMEOUT;
        assert(done2 = '1') report "FSMD_2 Done never asserted." severity warning;		  
		  assert(output2 = result) report "Incorrect FSM_D2 GCD" severity warning;

		  
  		   if done2 = '0' then
          errors2 := errors2 + 1;
        elsif output2 /= result then
          errors2 := errors2 + 1;
        end if;

        go <= '0';
        wait until clk'event and clk = '1';

      end loop;
    end loop;

    clkEn <= '0';
    report "DONE!!!!!!" severity note;
	 --***** FSMD
    if errors <= 10 then
      percent := 100-errors*10;
    else
      percent := 0;
    end if;
	 --***** FSM_D1
	 if errors1 <= 10 then
      percent1 := 100-errors1*10;
    else
      percent1 := 0;
    end if;
	 --***** FSM_D2
	 if errors2 <= 10 then
      percent2 := 100-errors2*10;
    else
      percent2 := 0;
    end if;
    report "FSMD PERCENTAGE = " & integer'image(percent) severity note;
	 report "FSM_D1 PERCENTAGE = " & integer'image(percent1) severity note;
	 report "FSM_D2 PERCENTAGE = " & integer'image(percent2) severity note;

    wait;

  end process;

end TB;

--configuration TB_CONFIG of gcd_tb is
--  for TB
--    for UUT : gcd
   --   use entity work.gcd(FSMD);
   -- end for;
 -- end for;
--end TB_CONFIG;

--FSMD
--FSM_D1
--FSM_D2
--FSMD2

