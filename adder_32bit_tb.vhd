----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 06:30:10 PM
-- Design Name: 
-- Module Name: adder_32bit_tb - Behavioral
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

entity adder_32bit_tb is
--  Port ( );
end adder_32bit_tb;

architecture Behavioral of adder_32bit_tb is
    component adder
           port(
           cin: in std_logic;
           a, b : in  STD_LOGIC_VECTOR(31 downto 0);
                   z : out STD_LOGIC_VECTOR(31 downto 0);
                   cout : out STD_LOGIC
           );
     end component;
     
     signal ai, bi, zi : STD_LOGIC_VECTOR(31 downto 0);
     signal cini : STD_LOGIC:='0';
     signal couti : STD_LOGIC:='0';

begin
UUT: adder port map(a=>ai, b=>bi, z=>zi, cin=>cini, cout=>couti);
    process
    begin
    ai <= "00000000000000000000000000000000";
    bi <= "00000000000000000000000000000000";
    wait for 100 ns;
    cini <= '1';
    ai <= "00000000000000000000000000000000";
    bi <= "00000000000000000001111111111111";
    wait for 100 ns;
    
    ai <= "00000000000000000000111111000000";
    bi <= "00000000000000000111100000000000";
    wait for 100 ns;
    end process;
end Behavioral;
