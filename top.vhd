----------------------------------------------------------------------------------
--
-- File: top.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/25/19
-- Description: Top level for project 3.  Contains entire MIPS datapath.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
		clk : in std_logic;
        led : out std_logic_vector (15 downto 0)
	);
end top;

architecture arch of top is

    -- program counter
    signal pc : std_logic_vector(31 downto 0) := (others => '0');
	signal pcplus4 : std_logic_vector(31 downto 0);
	signal pcplus8 : std_logic_vector(31 downto 0);
    
    -- instruction fields
	signal instruction : std_logic_vector(31 downto 0);
	signal opcode : std_logic_vector(5 downto 0);
	signal rs, rt, rd : std_logic_vector(4 downto 0);
	signal shamt : std_logic_vector(4 downto 0);
	signal funct : std_logic_vector(5 downto 0);
	signal immediate : std_logic_vector(15 downto 0);
	signal address : std_logic_vector(25 downto 0);
	
	-- control signals
	signal regdst: std_logic_vector(1 downto 0);
	signal jump: std_logic;
	signal branch: std_logic;
	signal memread: std_logic;
	signal regdatasel: std_logic_vector(1 downto 0);
	signal aluop: std_logic_vector(1 downto 0);
	signal memwrite: std_logic;
	signal alusrca: std_logic;
	signal alusrcb: std_logic;
	signal regwrite: std_logic;
	signal jumpreg: std_logic;
	
	-- register signals
	signal write_reg : std_logic_vector(4 downto 0);
    signal write_data : std_logic_vector(31 downto 0);
    signal read_data1 : std_logic_vector(31 downto 0);
	signal read_data2 : std_logic_vector(31 downto 0);
	
	-- alu signals
	signal alu_in_a : std_logic_vector(31 downto 0);
	signal alu_in_b : std_logic_vector(31 downto 0);
	signal alu_result : std_logic_vector(31 downto 0);
	signal zeroflag : std_logic;
	
	-- data memory signals
	signal dm_read_data : std_logic_vector(31 downto 0);
		
	-- intermediate misc. signals
	signal branch_sel : std_logic;
	signal t6 : std_logic_vector(31 downto 0);
	
	-- multiplexor outputs (top right of datapath)
	signal branch_mux_output : std_logic_vector(31 downto 0);
	signal jump_mux_output : std_logic_vector(31 downto 0);
	signal jumpreg_mux_output : std_logic_vector(31 downto 0);
	
	-- internal data signals
	signal branch_adder_result : std_logic_vector(31 downto 0);
	signal jump_address : std_logic_vector(31 downto 0);
	signal immediate_extended : std_logic_vector(31 downto 0);
	signal immediate_appended : std_logic_vector(31 downto 0);
	signal shamt_extended : std_logic_vector(31 downto 0);
	
begin
	----- MAIN COMPONENTS -----
	-- control, instruction memory, registers, ALU, and data memory
	control_unit: entity work.control port map(--
		opcode => opcode,
		funct => funct,
		regdst => regdst,
		jump => jump,
		branch => branch,
		memread => memread,
		regdatasel => regdatasel,
		aluop => aluop,
		memwrite => memwrite,
		alusrca => alusrca,
		alusrcb => alusrcb,
		regwrite => regwrite,
		jumpreg => jumpreg
	);
	
	instruction_memory: entity work.memory_unit(inst_arch) port map(
		clk => clk,
		address => pc(5 downto 0), -- take 6 lsbs because we only have 64 memory words
		data => x"00000000",
		write_enable => '0',
		output => instruction
	);
	
	register_unit: entity work.register_file port map(
		clock => clk,
		write_enable => regwrite,
		read_reg1 => rs,
		read_reg2 => rt,
		write_reg => write_reg,
		write_data => write_data,
		read_data1 => read_data1,
		read_data2 => read_data2,
		t6 => t6
	);
	
	alu_unit: entity work.alu port map(
		aluop => aluop,
		funccode => funct,
		a => alu_in_a,
		b => alu_in_b,
		result => alu_result,
		overflow => open,
		zeroflag => zeroflag,
		carryout => open
	);
	
	data_memory: entity work.memory_unit(data_arch) port map(
		clk => clk,
		address => alu_result(5 downto 0), -- take 6 lsbs because we only have 64 memory words
		data => read_data2,
		write_enable => memwrite,
		output => dm_read_data
	);
	----- END MAIN COMPONENTS -----
	
	----- ADDERS -----
	adder_pc4: entity work.adder port map(--
		cin => '0',
		a => pc,
		b => x"00000001",
		z => pcplus4,
		cout => open
	);
	
	adder_pc8: entity work.adder port map(--
		cin => '0',
		a => pc,
		b => x"00000002",
		z => pcplus8,
		cout => open
	);
	
	adder_branch: entity work.adder port map(
		cin => '0',
		a => pcplus4,
		b => immediate_extended,
		z => branch_adder_result,
		cout => open
	);
	----- END ADDERS -----
	
	----- 2 INPUT MULTIPLEXERS -----
	with branch_sel select branch_mux_output <=
	   pcplus4 when '0',
	   branch_adder_result when '1',
	   (others => 'X') when others;
	
	with jump select jump_mux_output <=
        branch_mux_output when '0',
        jump_address when '1',
        (others => 'X') when others;
    
    with jumpreg select jumpreg_mux_output <=
        jump_mux_output when '0',
        read_data1 when '1',
        (others => 'X') when others;
        
	with alusrca select alu_in_a <=
        read_data1 when '0',
        shamt_extended when '1',
        (others => 'X') when others;
	
	with alusrcb select alu_in_b <=
        read_data2 when '0',
        immediate_extended when '1',
        (others => 'X') when others;
	----- END 2 INPUT MULTIPLEXERS -----
	
	----- 4 INPUT MULTIPLEXERS -----
	-- select data to write to the register
	with regdatasel select write_data <=
        alu_result when "00",
        dm_read_data when "01",
        immediate_appended when "10",
        pcplus8 when "11",
        (others => 'X') when others;
	
	-- select destination register to write data to
	with regdst select write_reg <=
        rt when "00",
        rd when "01",
        "11111" when "10", --31
        "XXXXX" when "11",
        (others => 'X') when others;
	----- END 4 INPUT MULTIPLEXERS -----
	
	----- SIGNAL ASSIGNMENTS -----
	-- instruction signals
	opcode <= instruction(31 downto 26);
	rs <= instruction(25 downto 21);
	rt <= instruction(20 downto 16);
	rd <= instruction(15 downto 11);
	shamt <= instruction(10 downto 6);
	funct <= instruction(5 downto 0);
	immediate <= instruction(15 downto 0);
	address <= instruction(25 downto 0);
	
	-- resized signals to fit 32 bits
	shamt_extended <= x"000000" & "000" & shamt;
	immediate_appended <= immediate & x"0000";
	sign_extend_immediate: entity work.sign_extend port map(--
		input => immediate,
		output => immediate_extended
	);
	
	-- branch mux selector
	branch_sel <= zeroflag and branch;
	
	-- jump address is an offset from the PC's next value
	jump_address <= pcplus4(31 downto 28) & address & "00";
	
	-- assign lsb's 
	led <= t6(15 downto 0);
	----- END SIGNAL ASSIGNMENTS -----
    
	-- update PC on rising edge of the clock with the
	-- output of the series of branch/jump MUXes
	process (clk)
	begin
		if falling_edge(clk) and unsigned(jumpreg_mux_output) < 9 then
			  pc <= jumpreg_mux_output;
		end if;
	end process;
	
end arch;