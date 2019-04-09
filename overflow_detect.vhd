
-- arithmetic logic unit
-- need to add overflow detection unit and clean up the code
-- can we use ieee bit shift functions?

library IEEE;
use IEEE.std_logic_1164.all;

entity overflow_detect is
	port(
		ainvert, binvert, sign_a, sign_b, sign_result : in std_logic;
		overflow : out std_logic;
	);
end overflow_detect;

architecture arch of overflow_detect is

signal a_int, b_int;
signal sign: std_logic_vector(2 downto 0);

begin

a_int <= not sign_a when ainvert = '1' else sign_a;
b_int <= not sign_b when binvert = '1' else sign_b;

-- convert to vector for easy switch statement
sign(2) <= a_int;
sign(1) <= b_int;
sign(0) <= sign_result;

process(sign)
begin
	case sign is
		when "001" => overflow <= '1';
		when "110" => overflow <= '1';
		when others => overflow <= '0';
	end case;
end process


end alu_1bit_31;