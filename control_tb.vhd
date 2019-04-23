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

    signal opcode_s: std_logic_vector(5 downto 0);
    signal funct_s: std_logic_vector(5 downto 0);
    signal regdst_s: std_logic_vector(1 downto 0);
    signal jump_s: std_logic;
    signal branch_s: std_logic;
    signal memread_s: std_logic;
    signal regdatasel_s: std_logic_vector(1 downto 0);
    signal aluop_s: std_logic_vector(1 downto 0);
    signal memwrite_s: std_logic;
    signal alusrca_s: std_logic;
    signal alusrcb_s: std_logic;
    signal regwrite_s: std_logic;
	signal jumpreg_s: std_logic;
    

begin
UUT: entity work.control port map(opcode=>opcode_s, funct=>funct_s, regdst=>regdst_s,
                jump=>jump_s, branch=>branch_s, memread=>memread_s,
                regdatasel=>regdatasel_s, aluop=>aluop_s,
                memwrite=>memwrite_s, alusrca=>alusrca_s, alusrcb=>alusrcb_s,
                regwrite=>regwrite_s, jumpreg=>jumpreg_s);
                
    process
    begin
	
	-- test R type instructions
    opcode_s <= "000000";
	
	-- add
	funct_s <= "100000";
    wait for 10 ns;
    
    -- sub
	funct_s <= "100010";
    wait for 10 ns;
	
	-- and
	funct_s <= "100100";
    wait for 10 ns;
	
	-- or
	funct_s <= "100101";
    wait for 10 ns;
	
	-- sll
	funct_s <= "000000";
    wait for 10 ns;
	
	-- srl
	funct_s <= "000010";
    wait for 10 ns;
	
	-- slt
	funct_s <= "101010";
    wait for 10 ns;
	
	-- jr
	funct_s <= "001000";
    wait for 10 ns;
	
	-- test I type instructions
	funct_s <= "------";
	
	-- addi
	opcode_s <= "001000";
    wait for 10 ns;
	
	-- ori
	opcode_s <= "001101";
    wait for 10 ns;
	
	-- lui
	opcode_s <= "001111";
    wait for 10 ns;
	
	-- lw
	opcode_s <= "100011";
    wait for 10 ns;
	
	-- sw
	opcode_s <= "101011";
    wait for 10 ns;
	
	-- beq
	opcode_s <= "000100";
    wait for 10 ns;
	
	-- J type instructions
	-- jal
	opcode_s <= "000011";
    wait for 10 ns;
    
    end process;

end Behavioral;
