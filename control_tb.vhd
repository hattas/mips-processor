----------------------------------------------------------------------------------
--
-- File: control_tb.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/21/19
-- Description: This is the testbench for the control unit.
-- 		Test different instructions and control signal generation
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control_tb is
end control_tb;

architecture Behavioral of control_tb is

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
UUT: entity work.control port map(instruction=>instruction_s, regdst=>regdst_s,
                jump=>jump_s, branch=>branch_s, memread=>memread_s,
                memtoreg=>memtoreg_s, aluop=>aluop_s, luiwrite=>luiwrite_s,
                memwrite=>memwrite_s, alusrca=>alusrca_s, alusrcb=>alusrcb_s,
                regwrite=>regwrite_s, funct=>funct_s);
                
    process
    begin
    funct_s <= "100000";
    
    instruction_s <= "000000";
    wait for 10 ns;
    
    instruction_s <= "100011";
    wait for 10 ns;
    
    end process;

end Behavioral;
