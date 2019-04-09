-- register file

library IEEE;
use IEEE.std_logic_1164.all;

entity register_file is
	port(
		clock, write_enable: in std_logic;
		read_reg1, read_reg2, write_reg: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		read_data1, read_data2: out std_logic_vector(31 downto 0);
	);
end register_file;

architecture arch of register_file is

begin


end my_architecture;