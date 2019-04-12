-- 32-bit adder

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
	port(
		cin: in std_logic;
		a, b : in STD_LOGIC_VECTOR(31 downto 0);
		z  : out STD_LOGIC_VECTOR(31 downto 0);
		cout : out STD_LOGIC
	);
end adder;

architecture my_structure of adder is

component FULL_ADDER
	port( 
		x, y, cin : in  STD_LOGIC;
		sum, cout : out STD_LOGIC 
	);
end component;

-- carry outs
signal c : std_logic_vector(30 downto 0);

begin

first_adder: full_adder port map (x=>a(0), y=>b(0), cin=>cin, sum=>z(0), cout=>c(0));
for i in 1 to 30 generate
	adder_i: full_adder port map (x=>a(i), y=>b(i), cin=>c(i-1), sum=>z(i), cout=>c(i));
end generate;
last_adder: FULL_ADDER port map (x=>a(31), y=>b(31), cin=>c(30), sum=>z(31), cout=>cout);

END my_structure;