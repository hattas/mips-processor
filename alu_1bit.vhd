
-- arithmetic logic unit
-- need to add overflow detection unit and clean up the code
-- can we use ieee bit shift functions?

library IEEE;
use IEEE.std_logic_1164.all;

entity alu_1bit is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		alu_op: in std_logic_vector(1 downto 0);
		result: in std_logic_vector(31 downto 0);
		carryout, set, overflow: out std_logic;
	);
end alu_1bit;

architecture arch of alu is
signal c, b_int, a_int;
begin

c <= carryin;

process(a)
begin
	if ainvert = '1' then
		a_int <= not a;
	else
		a_int <= a;
	end if;
end process;

process(b)
begin
	if binvert = '1' then
		b_int <= not b;
	else
		b_int <= b;
	end if;
end process;

process(operation, a, b, c)
begin
	if operation = "00" then
		result <= a and b;
		carryout <= '0';
	elsif operation = "01" then
		result <= a or b;
		carryout <= '0';
	elsif operation = "10" then
		result <= (not a and not b and c) or (a and not b and not c) or (not a and b and not c) or (a and b and c);
		carryout <= (a and b) or (a and c) or (b and c);
	elseif operation = "11" then
		result <= less;
	end if;
end process;
	

end alu;