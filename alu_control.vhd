----------------------------------------------------------------------------------
--
-- file: alu_control.vhd
-- authors: Kyle Chang, John Hattas, Patrick Woodford
-- created: 4/8/19
-- description: ALU control unit used to determin ALU control bits
-- 		aluctl is 4 bits and is as follows
-- 		aluctl(3) is ainvert
-- 		aluctl(2) is bnegate
-- 		aluctl(1 downto 0) is operation
-- 		based on truth table on page 261
----------------------------------------------------------------------------------

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
	case aluop is
		when "00" =>
			aluctl <= "0010"; --add
		when "01" =>
			aluctl <= "0110"; --sub
		when "11" =>
			aluctl <= "0001"; --or
		when "10" =>
			case funccode(3 downto 0) is
				when "0000" => aluctl <= "0010"; --add
				when "0010" => aluctl <= "0110"; --sub
				when "0100" => aluctl <= "0000"; --and
				when "0101" => aluctl <= "0001"; --or
				when "1010" => aluctl <= "0111"; --slt
				when others => aluctl <= "XXXX"; --shouldn't happen
			end case;
		when others =>
		  aluctl <= "XXXX";
	end case;
end process;


end arch;