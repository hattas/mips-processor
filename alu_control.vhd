-- alu control unit
-- takes in aluop and function and determines alu control bits
-- aluctl is 4 bits and is as follows
-- aluctl(3) is ainvert
-- aluctl(2) is bnegate
-- aluctl(1 downto 0) is operation
-- based on truth table on page 261

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; --for unsigned

entity alu_control is
	port(
		aluop: in std_logic_vector(1 downto 0);
		funccode: in std_logic_vector(5 downto 0);
		aluctl: out std_logic_vector(3 downto 0)
	);
end alu_control;

architecture arch of alu_control is

begin

-- implement alu control truth table from page 261 of Computer Organization and Design
process(aluop, funccode)
begin
	if aluop = "00" then
		aluctl <= "0010"; --add
	elsif aluop(0) = '1' then
		aluctl <= "0110"; --sub
	elsif aluop(1) = '1' then
		case funccode(3 downto 0) is
			when "0000" => aluctl <= "0010"; --add
			when "0010" => aluctl <= "0110"; --sub
			when "0100" => aluctl <= "0000"; --and
			when "0101" => aluctl <= "0001"; --or
			when "1010" => aluctl <= "0111"; --slt
			when others => aluctl <= "XXXX"; --shouldn't happen
		end case;
	end if;
end process;


end arch;