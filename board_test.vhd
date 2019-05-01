----------------------------------------------------------------------------------
--
-- File: board_test.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 5/1/19
-- Description: Simple board test with same i/o as our top datapath.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity board_test is
    port (
		clk : in std_logic;
        led : out std_logic_vector (15 downto 0) -- LSBs of $t6
	);
end board_test;

architecture arch of board_test is
    signal clk_div : std_logic;
begin
    clk_div_unit: entity work.clk_divider port map(clk_in=>clk, clk_out=>clk_div);
    with clk_div select led <=
        (others => '0') when '0',
        (others => '1') when '1';
end arch;