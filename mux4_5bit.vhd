----------------------------------------------------------------------------------
--
-- File: mux4_5bit.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/25/19
-- Description: 4 input 5 bit mux with 2 bit select.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4_5bit is
    port (
		sel : in std_logic_vector(1 downto 0);
        in0, in1, in2, in3 : in std_logic_vector (4 downto 0);
        output : out std_logic_vector (4 downto 0)
	);
end mux4_5bit;

architecture arch of mux4_5bit is
begin
	with sel select output <=
		in0 when "00",
		in1 when "01",
		in2 when "10",
		in3 when "11",
		"00000" when others;
end arch;