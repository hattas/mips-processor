-- arithmetic logic unit
-- what is op and function?

library IEEE;
use IEEE.std_logic_1164.all;

entity alu32bit is
	port(
		ainvert, bnegate: in std_logic;
		operation: in std_logic_vector(1 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic
	);
end alu32bit;

architecture arch of alu32bit is

component alu is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		alu_op: in std_logic_vector(1 downto 0);
		result: in std_logic;
		carryout: out std_logic
	);
end component;

component alu1bit is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		operation: in std_logic_vector(1 downto 0);
		result: out std_logic;
		carryout: out std_logic
	);
end component;

component alu_msb is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		operation: in std_logic_vector(1 downto 0);
		result: out std_logic;
		carryout, set, overflow: out std_logic
	);
end component;

signal c_int: std_logic_vector(30 downto 0); -- intermediate carry signals
signal set: std_logic;
signal result_s: std_logic_vector(31 downto 0);

begin

result <= result_s;
zeroflag <= '1' when result_s = x"00000000" else '0';


-- first alu has carryin(bnegate) and less than signal
alu_first: alu1bit port map (a(0),  b(0),  bnegate, ainvert, bnegate, set, operation, result_s(0), c_int(0));
-- middle alus
jen:
for i in 1 to 30 generate
	alu_i: alu1bit port map (a(i), b(i), c_int(i-1), ainvert, bnegate, '0', operation, result_s(i), c_int(i));
end generate jen;
-- last alu has carryout
alu_last: alu_msb port map (a(31), b(31), c_int(30), ainvert, bnegate, '0', operation, result_s(31), carryout, set, overflow);
                                               
	
end arch;