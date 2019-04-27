----------------------------------------------------------------------------------
--
-- File: top_tb.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/27/19
-- Description: Top level test bench for the entire datapath.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

	constant half_period : time := 10 ns; -- 2 ns period
	signal clk_s: std_logic := '0';
	signal led_s : std_logic_vector(15 downto 0);
	
begin
    clk_s <= not clk_s after half_period;

    UUT: entity work.top port map(clk=>clk_s, led=>led_s);
	
end Behavioral;
