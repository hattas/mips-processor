-- arithmetic logic unit
-- what is op and function?

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port(
		alu_op: in std_logic_vector(1 downto 0);
		function_: in std_logic_vector(5 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: in std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic;
	);
end alu;

architecture arch of alu is

component alu_1bit is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		alu_op: in std_logic_vector(1 downto 0);
		result: in std_logic_vector(31 downto 0);
		carryout, set, overflow: out std_logic;
end component;



begin

process()
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