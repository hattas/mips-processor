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
        led : out std_logic_vector (15 downto 0); -- LSBs of $t6
		seg : out std_logic_vector(6 downto 0);
		an : out std_logic_vector(3 downto 0)
	);
end board_test;

architecture arch of board_test is
    signal clk_1hz, clk_seg : std_logic;
	signal seg0, seg1, seg2, seg3 : std_logic_vector(6 downto 0);
	signal led_count : unsigned(15 downto 0) := (others => '0');
	signal seg_count : unsigned(1 downto 0) := (others => '0');
begin
    clk_div_unit0: entity work.clk_divider port map(84, clk_in=>clk, clk_out=>clk_1hz);
    clk_div_unit1: entity work.clk_divider port map(10, clk_in=>clk, clk_out=>clk_seg);
	seg_unit0: entity work.hex_to_sseg port map(hex=>std_logic_vector(led_count(3 downto 0)), sseg=>seg0);
	seg_unit1: entity work.hex_to_sseg port map(hex=>std_logic_vector(led_count(7 downto 4)), sseg=>seg1);
	seg_unit2: entity work.hex_to_sseg port map(hex=>std_logic_vector(led_count(11 downto 8)), sseg=>seg2);
	seg_unit3: entity work.hex_to_sseg port map(hex=>std_logic_vector(led_count(15 downto 12)), sseg=>seg3);

	process(clk_1hz)
	begin
		if rising_edge(clk_1hz) then
			led_count <= led_count + 1;
		end if;
	end process;
	
	process(clk_seg)
    begin
        if rising_edge(clk_seg) then
            seg_count <= seg_count + 1;
        end if;
    end process;
	
	led <= std_logic_vector(led_count);
	
	process(seg_count, seg0, seg1, seg2, seg3)
	begin
        case seg_count is
            when "00" =>
                an <= "1110";
                seg <= seg0;
            when "01" =>
                an <= "1101";
                seg <= seg1;
            when "10" =>
                an <= "1011";
                seg <= "1000110"; --c
            when "11" =>
                an <= "0111";
                seg <= "0001100";
            when others =>
                an <= "1111";
                seg <= (others => '1');
        end case;
	end process;
	
end arch;