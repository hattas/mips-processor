-- register file
-- maybe use array of std_logic_vector?
-- use the address input to index into the array to get the data?


library IEEE;
use IEEE.std_logic_1164.all;

entity memory_unit is
	port(
		address: in std_logic_vector(5 downto 0);
		data: in std_logic_vector(31 downto 0);
		write_enable, clock: in std_logic;
		output: out std_logic_vector(31 downto 0);
	);
end memory_unit;

architecture arch of memory_unit is

begin


end memory_unit;