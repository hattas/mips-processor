-- arithmetic logic unit
-- based on top alu on page B-33

library IEEE;
use IEEE.std_logic_1164.all;

entity alu1bit is
	port(
		a, b, carryin, ainvert, binvert, less: in std_logic;
		operation: in std_logic_vector(1 downto 0);
		result: out std_logic;
		carryout: out std_logic
	);
end alu1bit;

architecture arch of alu1bit is

	signal b_int, a_int: std_logic;
	signal result_and, result_or, result_add: std_logic;

	component full_adder is
		port(
			x, y, cin: in std_logic;
			sum, cout: out std_logic
		);
	end component;

begin

	a_int <= not a when ainvert = '1' else a;
	b_int <= not b when binvert = '1' else b;

	result_and <= a_int and b_int;
	result_or <= a_int or b_int;
	fa: full_adder port map(a_int, b_int, carryin, result_add, carryout);

	result <= result_and when operation = "00" else 
			  result_or  when operation = "01" else 
			  result_add when operation = "10" else 
			  less       when operation = "11";
	
end arch;