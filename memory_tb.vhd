----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2019 02:24:55 PM
-- Design Name: 
-- Module Name: memory_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_tb is
--  Port ( );
end memory_tb;

architecture Behavioral of memory_tb is
    component memory_unit
        port(
            reset: in std_logic;
                clk: in std_logic;
                address: in std_logic_vector(5 downto 0);
                data: in std_logic_vector(31 downto 0);
                write_enable: in std_logic;
                output: out std_logic_vector(31 downto 0)
        
        );
    end component;
    
            signal address_s: std_logic_vector(5 downto 0);
            signal data_s: std_logic_vector(31 downto 0);
            signal write_enable_s: std_logic;
            signal reset_s: std_logic;
            signal clk_s: std_logic;
            signal output_s: std_logic_vector(31 downto 0);

begin
UUT: memory_unit port map(address=>address_s, data=>data_s, write_enable=>write_enable_s, 
                    clk=>clk_s, output=>output_s, reset=>reset_s);
    process
    begin
        clk_s <= '1';
        write_enable_s <= '1';
        address_s <= "001000";
        data_s <= X"00001000";
        reset_s <= '0';
        wait for 100 ns;
        
        clk_s<='0';
        write_enable_s <= '1';
        address_s <= "000010";
        data_s<= X"00000001";
        reset_s <= '1';
        wait for 100 ns;
        
        clk_s <= '1';
        write_enable_s <= '0';
        address_s <= "000100";
        data_s<= X"00000010";
        reset_s <= '1';
        wait for 100 ns;
    end process;
end Behavioral;