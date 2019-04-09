-- arithmetic logic unit
-- need to add overflow detection unit and clean up the code
-- can we use ieee bit shift functions?

library IEEE;
use IEEE.std_logic_1164.all;

entity alu_msb is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		alu_op: in std_logic_vector(1 downto 0);
		result: in std_logic_vector(31 downto 0);
		carryout, set, overflow: out std_logic;
	);
end alu_msb;

architecture arch of alu_msb is

signal c, b_int, a_int;

component full_adder is
	port(
		x, y, cin: in std_logic;
		sum, cout: out std_logic
	);
end component;

component overflow_detect is
	port(
		ainvert, binvert, sign_a, sign_b, sign_result : in std_logic;
		overflow : out std_logic;
	);
end component;

begin

c <= carryin;

a_int <= not a when ainvert = '1' else a;
b_int <= not b when binvert = '1' else b;

result_and <= a_int and b_int;
result_or <= a_int or b_int;
u1: full_adder port map(a_int, b_int, carryin, result_add, carryout);
u2: overflow_detect port map(ainvert, binvert, a_int(31), b_int(31), result_add(31), overflow);
set <= result_add(31); -- 1 if negative for slt

mux1: process(operation)
begin
	case operation is
		when "00" => result <= result_and;
		when "01" => result <= result_or;
		when "10" => result <= result_add;
		when "11" => result <= less;
	end case;
end process mux1;
	
end alu_msb;