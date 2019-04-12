-- alu top

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port(
		aluop: in std_logic_vector(1 downto 0);
		funccode: in std_logic_vector(5 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic;
	);
end alu;

architecture arch of alu is

	component alu32bit is
		port(
			ainvert, bnegate: in std_logic;
			operation: in std_logic_vector(1 downto 0);
			a, b: in std_logic_vector(31 downto 0);
			result: out std_logic_vector(31 downto 0);
			overflow, zeroflag, carryout: out std_logic;
		);
	end component;
	
	component alu_control is
		port(
			aluop: in std_logic_vector(1 downto 0);
			funccode: in std_logic_vector(5 downto 0);
			aluctl: out std_logic_vector(3 downto 0);
		);
	end component;
	
	signal aluctl;
	
begin

	ac: alu_control port map(aluop, funcode, aluctl);
	alu32: alu32bit port map(
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

end alu;