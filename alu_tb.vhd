----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2019 07:23:12 PM
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is
component alu is
	port(
		aluop: in std_logic_vector(1 downto 0);
		funccode: in std_logic_vector(5 downto 0);
		a, b: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0);
		overflow, zeroflag, carryout: out std_logic
	);
    end component;
     
    signal aluop_s:  std_logic_vector(1 downto 0);
    signal funccode_s:  std_logic_vector(5 downto 0);
    signal a_s, b_s: std_logic_vector(31 downto 0);
    signal result_s:  std_logic_vector(31 downto 0);
    signal overflow_s, zeroflag_s, carryout_s:  std_logic;

begin
UUT: alu port map(aluop=>aluop_s, funccode=>funccode_s, a=>a_s,
                  b=>b_s, result=>result_s, overflow=>overflow_s,
                  zeroflag=>zeroflag_s, carryout=>carryout_s);
    process
    begin
        
        
        -- add section
        funccode_s <= "100000";
        aluop_s <= "00";
        
        -- add zero test
        a_s <= x"00000000";
        b_s <= x"00000000";
        wait for 100 ns;
        -- add general test no carry out
        a_s <= x"00010010";
        b_s <= x"00011000";
        wait for 100 ns;
        -- no overflow, carry out
        a_s <= x"FFFFFFFF"; -- -1
        b_s <= x"00000001"; -- 1
        wait for 100 ns;
        -- overflow and carry out
        a_s <= x"80000000";
        b_s <= x"80000000";
        wait for 100 ns;
        -- no overflow no nothing
        a_s <= x"0FFFFFFF";
        b_s <= x"00000001";
        wait for 100 ns;
        -- overflow no carry out
        a_s <= x"40000000";
        b_s <= x"40000000";
        wait for 100 ns;
        
        a_s <= x"00000000"; -- -1
        b_s <= x"00000000"; -- 1
        wait for 500 ns;
        -- subtraction
        funccode_s <= "100010";
        aluop_s <= "00";
        
        a_s <= x"00000002";
        b_s <= x"00000001";
        wait for 100 ns;
        a_s <= x"00000001";
        b_s <= x"00000001";
        wait for 100 ns;
        a_s <= x"FFFFFFFF";
        b_s <= x"FFFFFFFF";
        wait for 100 ns;
        a_s <= x"F4873ABC";
        b_s <= x"10932498";
        wait for 100 ns;
        
           
        
    end process;
end Behavioral;
