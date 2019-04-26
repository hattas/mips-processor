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

entity top is
    port (
		clk : in std_logic;
        led : out std_logic_vector (15 downto 0) -- LSBs of $t6
	);
end top;

architecture arch of top is
    -- program counter
    signal pc : std_logic_vector(31 downto 0);

	-- control signals
	signal opcode : std_logic_vector(5 downto 0);
	signal funct : std_logic_vector(5 downto 0);
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
	signal read_reg1 : std_logic_vector(4 downto 0);
	signal read_reg2 : std_logic_vector(4 downto 0);
	signal write_reg : std_logic_vector(4 downto 0);
    signal write_data : std_logic_vector(31 downto 0);
    signal read_data1 : std_logic_vector(31 downto 0);
	signal read_data2 : std_logic_vector(31 downto 0);
	
	-- branch and jump signals
	signal pcplus4 : std_logic_vector(31 downto 0);
	signal pcplus8 : std_logic_vector(31 downto 0);
	
	-- alu signals
	signal zeroflag : std_logic;
	signal alu_in_a : std_logic_vector(31 downto 0);
	signal alu_in_b : std_logic_vector(31 downto 0);
	signal alu_result : std_logic_vector(31 downto 0);
	signal funccode : std_logic_vector(5 downto 0);
	
	-- data memory signals
	signal dm_read_data : std_logic_vector(31 downto 0);
	
	-- instruction memory
	signal instruction : std_logic_vector(31 downto 0);
	
	-- intermediate misc. signals
	signal immediate : std_logic_vector(15 downto 0);
	signal shamt : std_logic_vector(4 downto 0);
	signal branch_sel : std_logic;
	signal branch_adder_result : std_logic_vector(31 downto 0);
	signal jump_mux_output : std_logic_vector(31 downto 0);
	signal branch_mux_output : std_logic_vector(31 downto 0);
	signal jumpreg_mux_output : std_logic_vector(31 downto 0);
	signal jump_address : std_logic_vector(31 downto 0);
	
	-- data signals
	signal immediate_extended : std_logic_vector(31 downto 0);
	signal immediate_appended : std_logic_vector(31 downto 0);
	signal shamt_extended : std_logic_vector(31 downto 0);
	
begin
	----- create entities -----
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
	
	register_unit: entity work.register_file port map(
		clock => clk,
		write_enable => regwrite,
		read_reg1 => read_reg1,
		read_reg2 => read_reg2,
		write_reg => write_reg,
		write_data => write_data,
		read_data1 => read_data1,
		read_data2 => read_data2
	);
	
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

	adder_pc4: entity work.adder port map(--
		cin => '0',
		a => pc,
		b => x"00000004",
		z => pcplus4,
		cout => open
	);
	
	adder_pc8: entity work.adder port map(--
		cin => '0',
		a => pc,
		b => x"00000008",
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
	
	instruction_memory: entity work.memory_unit port map(
		clk => clk,
		address => pc(5 downto 0), -- take 6 lsbs because we only have 64 memory words
		data => x"00000000",
		write_enable => '0',
		output => instruction
	);
	
	data_memory: entity work.memory_unit port map(
		clk => clk,
		address => alu_result(5 downto 0), -- take 6 lsbs because we only have 64 memory words
		data => read_data2,
		write_enable => memwrite,
		output => dm_read_data
	);
	
	mux2_branch: entity work.mux2 port map(
		sel => branch_sel,
		in0 => pcplus4,
		in1 => branch_adder_result,
		output => branch_mux_output
	);
	
	mux2_jump: entity work.mux2 port map(
		sel => jump,
		in0 => branch_mux_output,
		in1 => jump_address,
		output => jump_mux_output
	);
	
	mux2_jumpreg: entity work.mux2 port map(
		sel => jumpreg,
		in0 => jump_mux_output,
		in1 => read_data1,
		output => jumpreg_mux_output
	);
	
	mux2_alusrca: entity work.mux2 port map(
		sel => alusrca,
		in0 => read_data1,
		in1 => shamt_extended,
		output => alu_in_a
	);
	
	mux2_alusrcb: entity work.mux2 port map(
		sel => alusrcb,
		in0 => read_data2,
		in1 => immediate_extended,
		output => alu_in_b
	);
	
	mux4_regdata: entity work.mux4 port map(
		sel => regdatasel,
		in0 => alu_result,
		in1 => dm_read_data,
		in2 => immediate_appended,
		in3 => pcplus8,
		output => write_data
	);
	
	mux4_regdst: entity work.mux4_5bit port map(--
		sel => regdst,
		in0 => instruction(20 downto 16),
		in1 => instruction(15 downto 11),
		in2 => "11111",
		in3 => "XXXXX",
		output => write_reg
	);
	
	sign_extend_immediate: entity work.sign_extend port map(--
		input => immediate,
		output => immediate_extended
	);
	
	----- signal assignments -----
	branch_sel <= zeroflag and branch;
	opcode <= instruction(31 downto 26);
	read_reg1 <= instruction(25 downto 21);
	read_reg2 <= instruction(20 downto 16);
	immediate <= instruction(15 downto 0);
	shamt <= instruction(10 downto 6);
	funct <= instruction(5 downto 0);
	jump_address <= pcplus4(31 downto 28) & instruction(25 downto 0) & "00";
	shamt_extended <= x"000000" & "000" & shamt;
	immediate_appended <= immediate & x"0000";
	
	process (clk)
	begin
		if rising_edge(clk) then
			pc <= jumpreg_mux_output;
		end if;
	end process;
	
end arch;