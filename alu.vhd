-- top level alu
-- contains 32 bit alu and alu control

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port(
		aluop: in std_logic_vector(1 downto 0);
		funccode: in std_logic_vector(5 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic
	);
end alu;

architecture arch of alu is
	signal aluctl: std_logic_vector(3 downto 0);	
begin

	ac: entity work.alu_control port map(aluop=>aluop, funccode=>funccode, aluctl=>aluctl);
	alu32: entity work.alu32bit port map(
		ainvert=>aluctl(3),
		bnegate=>aluctl(2),
		operation=>aluctl(1 downto 0),
		a=>a,
		b=>b,
		result=>result,
		overflow=>overflow,
		zeroflag=>zeroflag,
		carryout=>carryout
	);

end arch;