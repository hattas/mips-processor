----------------------------------------------------------------------------------
--
-- File: mux4.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/25/19
-- Description: 4 input 32 bit mux with 2 bit select.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
    port (
		sel : in std_logic_vector(1 downto 0);
        in0, in1, in2, in3 : in std_logic_vector (31 downto 0);
        output : out std_logic_vector (31 downto 0)
	);
end mux4;

architecture arch of mux4 is
begin
	with sel select output <=
		in0 when "00",
		in1 when "01",
		in2 when "10",
		in3 when "11";
end arch;