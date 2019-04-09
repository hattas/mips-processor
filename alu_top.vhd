-- arithmetic logic unit
-- what is op and function?

library IEEE;
use IEEE.std_logic_1164.all;

entity alu_top is
	port(
		alu_op: in std_logic_vector(1 downto 0);
		function_: in std_logic_vector(5 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic;
	);
end alu_top;

architecture arch of alu_top is

component alu is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		alu_op: in std_logic_vector(1 downto 0);
		result: in std_logic;
		carryout: out std_logic;
end component;

signal c: std_logic_vector(30 downto 0); -- intermediate carry signals
signal set: std_logic;

begin

zeroflag <= '1' when result = x"00000000" else '0';


-- first alu has carryin and less than signal
alu_first: alu port map (a(0),  b(0),  carryin, ainvert, binvert, set, alu_op, result(0), c(0));
-- middle alus
for i in 1 to 30 generate
	alu_i: alu port map (a(i), b(i), c(i-1), ainvert, binvert, '0', alu_op, result(i), c(i));
end generate;
-- last alu has carryout
alu_last: alu_msb port map (a(31), b(31), c(30), ainvert, binvert, '0', alu_op, result(31), carryout, set, overflow);
                                               
	
end alu_top;