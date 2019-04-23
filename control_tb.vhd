----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2019 04:39:12 PM
-- Design Name: 
-- Module Name: control_tb - Behavioral
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

entity control_tb is
--  Port ( );
end control_tb;

architecture Behavioral of control_tb is
    component control
        port(
            instruction: in std_logic_vector(5 downto 0);
            regdst: out std_logic_vector(1 downto 0);
            jump: out std_logic;
            branch: out std_logic;
            memread: out std_logic;
            memtoreg: out std_logic_vector(1 downto 0);
            aluop: out std_logic_vector(1 downto 0);
            memwrite: out std_logic;
            alusrca: out std_logic;
            alusrcb: out std_logic;
            regwrite: out std_logic;
            luiwrite: out std_logic;
            funct: in std_logic_vector(5 downto 0)
        );
    end component;

    signal instruction_s: std_logic_vector(5 downto 0);
    signal regdst_s: std_logic_vector(1 downto 0);
    signal jump_s: std_logic;
    signal branch_s: std_logic;
    signal memread_s: std_logic;
    signal memtoreg_s: std_logic_vector(1 downto 0);
    signal aluop_s: std_logic_vector(1 downto 0);
    signal memwrite_s: std_logic;
    signal alusrca_s: std_logic;
    signal alusrcb_s: std_logic;
    signal regwrite_s: std_logic;
    signal luiwrite_s: std_logic;
    signal funct_s: std_logic_vector(5 downto 0);

begin
UUT: control port map(instruction=>instruction_s, regdst=>regdst_s,
                jump=>jump_s, branch=>branch_s, memread=>memread_s,
                memtoreg=>memtoreg_s, aluop=>aluop_s, luiwrite=>luiwrite_s,
                memwrite=>memwrite_s, alusrca=>alusrca_s, alusrcb=>alusrcb_s,
                regwrite=>regwrite_s, funct=>funct_s);
                
    process
    begin
    funct_s <= "100000";
    
    instruction_s <= "000000";
    wait for 100 ns;
    
    instruction_s <= "100011";
    wait for 100 ns;
    
    end process;

end Behavioral;
