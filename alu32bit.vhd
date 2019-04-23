----------------------------------------------------------------------------------
--
-- file: alu32bit.vhd
-- authors: Kyle Chang, John Hattas, Patrick Woodford
-- created: 4/8/19
-- description: This is the 32 bit ALU that instantiates 32 1 bit ALUs.
--    	The most significant bit uses the alu_msb to allow for overflow or less than detection.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity alu32bit is
	port(
		ainvert, bnegate: in std_logic;
		operation: in std_logic_vector(1 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic
	);
end alu32bit;

architecture arch of alu32bit is

signal c_int: std_logic_vector(30 downto 0); -- intermediate carry signals
signal set: std_logic;
signal result_s: std_logic_vector(31 downto 0);

begin

result <= result_s;
zeroflag <= '1' when result_s = x"00000000" else '0';


-- first alu has carryin(bnegate) and less than signal
alu_first: entity work.alu1bit port map (a(0),  b(0),  bnegate, ainvert, bnegate, set, operation, result_s(0), c_int(0));
-- middle alus
jen:
for i in 1 to 30 generate
	alu_i: entity work.alu1bit port map (a(i), b(i), c_int(i-1), ainvert, bnegate, '0', operation, result_s(i), c_int(i));
end generate jen;
-- last alu has carryout
alu_last: entity work.alu_msb port map (a(31), b(31), c_int(30), ainvert, bnegate, '0', operation, result_s(31), carryout, set, overflow);
                                               
	
end arch;