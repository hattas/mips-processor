-- arithmetic logic unit
-- based on top alu on page B-33

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		alu_op: in std_logic_vector(1 downto 0);
		result: in std_logic_vector(31 downto 0);
		carryout: out std_logic;
	);
end alu;

architecture arch of alu is

signal c, b_int, a_int;

component full_adder is
	port(
		x, y, cin: in std_logic;
		sum, cout: out std_logic
	);
end component;

begin

c <= carryin;

a_int <= not a when ainvert = '1' else a;
b_int <= not b when binvert = '1' else b;

result_and <= a_int and b_int;
result_or <= a_int or b_int;
fa: full_adder port map(a_int, b_int, carryin, result_add, carryout);


mux1: process(operation)
begin
	case operation is
		when "00" => result <= result_and;
		when "01" => result <= result_or;
		when "10" => result <= result_add;
		when "11" => result <= less;
	end case;
end process mux1;
	

end alu;