----------------------------------------------------------------------------------
--
-- File: sign_extend.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/25/19
-- Description: sign extend 16 bits to 32 bits.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity sign_extend is
    port (
		input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector (31 downto 0)
	);
end sign_extend;

architecture arch of sign_extend is
	signal sign : std_logic;
begin
    sign <= input(15);
    process(sign, input)
    begin
        if sign = '0' then
            output <= x"0000" & input;
        else
            output <= x"FFFF" & input;
        end if;
    end process;
end arch;