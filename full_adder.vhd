-- 1-bit full adder

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
	port(
		x, y, cin: in std_logic;
		sum, cout: out std_logic
	);
end full_adder;

architecture my_dataflow of full_adder is

begin

sum <= (x xor y) xor cin;
cout <= (x and y) or (x and cin) or (y and cin);

end my_dataflow;
