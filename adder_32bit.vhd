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

architecture MY_STRUCTURE of adder is

component FULL_ADDER
	port( 
		x, y, cin : in  STD_LOGIC;
		sum, cout : out STD_LOGIC 
	);
end component;

signal c : std_logic_vector(31 downto 0);

begin

c(0) <= cin;
b_adder0:  FULL_ADDER port map (a(0),  b(0),  c(0),  z(0),  c(1));
b_adder1:  FULL_ADDER port map (a(1),  b(1),  c(1),  z(1),  c(2));
b_adder2:  FULL_ADDER port map (a(2),  b(2),  c(2),  z(2),  c(3));
b_adder3:  FULL_ADDER port map (a(3),  b(3),  c(3),  z(3),  c(4));
b_adder4:  FULL_ADDER port map (a(4),  b(4),  c(4),  z(4),  c(5));
b_adder5:  FULL_ADDER port map (a(5),  b(5),  c(5),  z(5),  c(6));
b_adder6:  FULL_ADDER port map (a(6),  b(6),  c(6),  z(6),  c(7));
b_adder7:  FULL_ADDER port map (a(7),  b(7),  c(7),  z(7),  c(8));
b_adder8:  FULL_ADDER port map (a(8),  b(8),  c(8),  z(8),  c(9));
b_adder9:  FULL_ADDER port map (a(9),  b(9),  c(9),  z(9),  c(10));
b_adder10: FULL_ADDER port map (a(10), b(10), c(10), z(10), c(11));
b_adder11: FULL_ADDER port map (a(11), b(11), c(11), z(11), c(12));
b_adder12: FULL_ADDER port map (a(12), b(12), c(12), z(12), c(13));
b_adder13: FULL_ADDER port map (a(13), b(13), c(13), z(13), c(14));
b_adder14: FULL_ADDER port map (a(14), b(14), c(14), z(14), c(15));
b_adder15: FULL_ADDER port map (a(15), b(15), c(15), z(15), c(16));
b_adder16: FULL_ADDER port map (a(16), b(16), c(16), z(16), c(17));
b_adder17: FULL_ADDER port map (a(17), b(17), c(17), z(17), c(18));
b_adder18: FULL_ADDER port map (a(18), b(18), c(18), z(18), c(19));
b_adder19: FULL_ADDER port map (a(19), b(19), c(19), z(19), c(20));
b_adder20: FULL_ADDER port map (a(20), b(20), c(20), z(20), c(21));
b_adder21: FULL_ADDER port map (a(21), b(21), c(21), z(21), c(22));
b_adder22: FULL_ADDER port map (a(22), b(22), c(22), z(22), c(23));
b_adder23: FULL_ADDER port map (a(23), b(23), c(23), z(23), c(24));
b_adder24: FULL_ADDER port map (a(24), b(24), c(24), z(24), c(25));
b_adder25: FULL_ADDER port map (a(25), b(25), c(25), z(25), c(26));
b_adder26: FULL_ADDER port map (a(26), b(26), c(26), z(26), c(27));
b_adder27: FULL_ADDER port map (a(27), b(27), c(27), z(27), c(28));
b_adder28: FULL_ADDER port map (a(28), b(28), c(28), z(28), c(29));
b_adder29: FULL_ADDER port map (a(29), b(29), c(29), z(29), c(30));
b_adder30: FULL_ADDER port map (a(30), b(30), c(30), z(30), c(31));
b_adder31: FULL_ADDER port map (a(31), b(31), c(31), z(31), cout);

END MY_STRUCTURE;
