library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder7seg_true_testbench is  
end decoder7seg_true_testbench;

architecture TB of decoder7seg_true_testbench is

    component decoder7seg
    port (
        input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(6 downto 0)
    );
    end component;

    -- Driver
    signal input : std_logic_vector(3 downto 0);

    signal output, correct : std_logic_vector(6 downto 0); 


    type decoded_values_arr is array(0 to 15) of std_logic_vector(6 downto 0);

    -- Active-low 7-segment decodings.
    constant decoded_values: decoded_values_arr := (
        -- msb .. lsb
        "1000000", -- 0
        "1111001", -- 1 
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0011000", -- 9 
        "0001000", -- 10 A
        "0000011", -- 11 B
        "1000110", -- 12 C 
        "0100001", -- 13 D 
        "0000110", -- 14 E
        "0001110"  -- 15 F
    );

begin  -- TB

    UUT: decoder7seg
    port map (
        input  => input,
        output => output
    );

    process begin

        for i in 0 to 15 loop
            correct <= decoded_values(i);
            input <= std_logic_vector(to_unsigned(i, 4)); -- Make i a 4-bit vector

            wait for 10 ns;

            assert(output = correct) report "Incorrect decoding for " & integer'image(i);
        end loop;
        
        report "Done. Goodbye.";
        wait;
    end process;

end TB;

