
-- overflow detection unit

library IEEE;
use IEEE.std_logic_1164.all;

entity overflow_detect is
	port(
		sign_a, sign_b, sign_result : in std_logic;
		overflow : out std_logic;
	);
end overflow_detect;

architecture arch of overflow_detect is

signal sign_a_int, sign_b_int;
signal sign: std_logic_vector(2 downto 0);

begin

-- convert to vector for easy switch statement
sign(2) <= sign_a;
sign(1) <= sign_b;
sign(0) <= sign_result;

			-- add 2 positive and get negative
overflow <= '1' when not sign_a and not sign_b and sign_result else 4
			-- add 2 negatives and get positive
            '1' when sign_a and sign_b and not sign_result else 
            '0';

end overflow_detect;