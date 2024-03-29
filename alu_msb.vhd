----------------------------------------------------------------------------------
--
-- file: alu_msb.vhd
-- authors: Kyle Chang, John Hattas, Patrick Woodford
-- created: 4/8/19
-- description: 1 bit ALU for the most significant bit.
-- 		Same function as 1 bit ALU but it has overflow detection and slt support.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity alu_msb is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		operation: in std_logic_vector(1 downto 0);
		result: out std_logic;
		carryout, set, overflow: out std_logic
	);
end alu_msb;

architecture arch of alu_msb is

	signal b_int, a_int: std_logic;
	signal result_and, result_or, result_add: std_logic;

begin

	a_int <= not a when ainvert = '1' else a;
	b_int <= not b when binvert = '1' else b;

	result_and <= a_int and b_int;
	result_or <= a_int or b_int;
	fa: entity work.full_adder port map(a_int, b_int, carryin, result_add, carryout);
	od: entity work.overflow_detect port map(a_int, b_int, result_add, overflow);

	result <= result_and when operation = "00" else 
			  result_or  when operation = "01" else 
			  result_add when operation = "10" else 
			  less       when operation = "11";
	
	slt_process: process(result_add, a, b)
	begin
	   -- a is negative and b is positive, less than
	   if a = '1' and b = '0' then
	       set <= '1';
	   -- a positive, b negative, not less than
	   elsif a = '0' and b = '1' then
	       set <= '0';
	   else
	       set <= result_add;
	   end if;
	end process slt_process;
end arch;