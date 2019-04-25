----------------------------------------------------------------------------------
--
-- File: mux2.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/25/19
-- Description: 2 input mux with 1 bit select.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
    port (
		sel : in std_logic;
        in0, in1 : in std_logic_vector (31 downto 0);
        output : out std_logic_vector (31 downto 0)
	);
end mux2;

architecture arch of mux2 is
begin
	with sel select output <=
		in0 when '0',
		in1 when '1';
end arch;