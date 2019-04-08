-- arithmetic logic unit

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port(
		alu_op: in std_logic_vector(1 downto 0);
		function_: in std_logic_vector(5 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: in std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic;
end alu;

architecture arch of alu is

begin


end alu;