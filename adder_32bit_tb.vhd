----------------------------------------------------------------------------------
--
-- file: adder_32bit_tb.vhd
-- authors: Kyle Chang, John Hattas, Patrick Woodford
-- created: 4/12/19
-- description: This is the testbench for the 32 bit adder.
-- 		It tests various combinations of inputs with and without carry in.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_32bit_tb is
end adder_32bit_tb;

architecture Behavioral of adder_32bit_tb is
     signal ai, bi, zi : STD_LOGIC_VECTOR(31 downto 0);
     signal cini : STD_LOGIC := '0';
     signal couti : STD_LOGIC := '0';
begin
	UUT: entity work.adder port map(a=>ai, b=>bi, z=>zi, cin=>cini, cout=>couti);
    process
    begin
		-- zero test
		ai <= x"00000000";
		bi <= x"00000000";
		wait for 10 ns;
		
		-- carry in test
		cini <= '1';
		ai <= x"00000000";
		bi <= x"0000ffff";
		wait for 10 ns;
		
		-- carry out test
		cini <= '0';
		ai <= x"ffffffff";
		bi <= x"00000001";
		wait for 10 ns;
		
		-- carry out and carry in test
		cini <= '1';
		ai <= x"ffffffff";
		bi <= x"00000000";
		wait for 10 ns;
		
		-- general test
		cini <= '0';
		ai <= x"194ad342";
		bi <= x"5be9485f";
		wait for 10 ns;
		
    end process;
end Behavioral;
