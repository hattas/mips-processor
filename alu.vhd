-- top level alu
-- contains 32 bit alu and alu control

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; -- for shifting

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
	signal result_alu32: std_logic_vector(31 downto 0);
begin

	ac: entity work.alu_control port map(aluop=>aluop, funccode=>funccode, aluctl=>aluctl);
	alu32: entity work.alu32bit port map(
		ainvert=>aluctl(3),
		bnegate=>aluctl(2),
		operation=>aluctl(1 downto 0),
		a=>a,
		b=>b,
		result=>result_alu32,
		overflow=>overflow,
		zeroflag=>zeroflag,
		carryout=>carryout
	);
	
	shift_process: process(a, b, aluop, funccode, result_alu32)
	begin
	   -- SLL
	   if aluop(1) = '1' and funccode = "000000" then
	       result <= std_logic_vector(shift_left(unsigned(b), to_integer(unsigned(a))));
	   -- SRL
	   elsif aluop(1) = '1' and funccode = "000010" then
	       result <= std_logic_vector(shift_right(unsigned(b), to_integer(unsigned(a))));
	   -- normal alu result
       else
           result <= result_alu32;
       end if;
	end process shift_process;

end arch;