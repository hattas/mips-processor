
-- overflow detection unit

library IEEE;
use IEEE.std_logic_1164.all;

entity overflow_detect is
	port(
		sign_a, sign_b, sign_result : in std_logic;
		overflow : out std_logic
	);
end overflow_detect;

architecture arch of overflow_detect is

signal sign_a_int, sign_b_int: std_logic;
signal sign: std_logic_vector(2 downto 0);

begin

-- convert to vector for easy switch statement
sign(2) <= sign_a;
sign(1) <= sign_b;
sign(0) <= sign_result;

            
overflow <= '1' when sign = "110" else
            '1' when sign = "001" else 
            '0';

end arch;