
-- alu control unit
-- page B-38 is the verilog example

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

process(funccode)
begin
    case to_integer(unsigned(funccode)) is -- convert to integer for switch statement
        when 32 => --add
			aluctl <= "0010"; --2
		when 34 => --sub
			aluctl <= "0110"; --6
		when 36 => --and
			aluctl <= "0000"; --0
		when 37 => --or
			aluctl <= "0001"; --1
		when 39 => --nor
			aluctl <= "1100"; --12
		when 42 => --slt
			aluctl <= "0111"; --7
        when others =>
			aluctl <= "1111"; -- 15 (should not happen)
    end case;
end process;


end arch;