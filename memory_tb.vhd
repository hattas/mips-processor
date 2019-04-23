----------------------------------------------------------------------------------
--
-- File: register_file_tb.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/21/19
-- Description: This is the testbench for the memory unit.
-- 		We write and read to various memory addresses to ensure proper operation.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity memory_tb is
end memory_tb;

architecture Behavioral of memory_tb is
    
            constant half_period : time := 1 ns; -- 2 ns period
            signal address_s: std_logic_vector(5 downto 0);
            signal data_s: std_logic_vector(31 downto 0);
            signal write_enable_s: std_logic;
            signal reset_s: std_logic;
            signal clk_s: std_logic := '0';
            signal output_s: std_logic_vector(31 downto 0);
begin
    clk_s <= not clk_s after half_period;

    UUT: entity work.memory_unit port map(address=>address_s, data=>data_s, write_enable=>write_enable_s, 
                    clk=>clk_s, output=>output_s);
    process
    begin
        write_enable_s <= '1';
        address_s <= "001000";
        data_s <= X"00001000";
        reset_s <= '0';
        wait for 10 ns;
        
        write_enable_s <= '1';
        address_s <= "000010";
        data_s<= X"00000001";
        reset_s <= '1';
        wait for 10 ns;
        
        write_enable_s <= '0';
        address_s <= "000100";
        data_s<= X"00000010";
        reset_s <= '1';
        wait for 10 ns;
    end process;
end Behavioral;
