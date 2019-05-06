----------------------------------------------------------------------------------
--
-- file: memory_unit.vhd
-- authors: Kyle Chang, John Hattas, Patrick Woodford
-- created: 4/12/19
-- description: This is a 64x32 top level SRAM unit.
-- 		The memory is preloaded to be all zeros.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_unit is
	port(
		clk: in std_logic;
		address: in std_logic_vector(5 downto 0);
		data: in std_logic_vector(31 downto 0);
		write_enable: in std_logic;
		output: out std_logic_vector(31 downto 0)
	);
end memory_unit;

architecture data_arch of memory_unit is

		type MEM_ARRAY_64x32 is array(0 to 63) of std_logic_vector(31 downto 0);
		signal memory_array:MEM_ARRAY_64x32 :=(
		  x"00000003", x"00000004", x"00000005", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000"
		);

	begin
	   process(clk, write_enable, address, data) 
	   begin
	       -- synchronous write
		  if rising_edge(clk) and write_enable = '1' then
			memory_array(to_integer(unsigned(address))) <= data;
		  end if;
		  -- asynchronous continuous read of the data memory location at address var_addr 
		  output <= memory_array(to_integer(unsigned(address)));
	end process;

end data_arch;

architecture inst_arch of memory_unit is

		type MEM_ARRAY_64x32 is array(0 to 63) of std_logic_vector(31 downto 0);
		signal memory_array:MEM_ARRAY_64x32 :=(
		  -- mips program
		  --9 lines
		  --| op | rs  | rt  |      imm        |
		  --| op | rs  | rt  | rd  |shamt| func |
		  b"100011_10000_01001_0000000000000000", 	    -- lw   $t1, 0($s0)		x23, 16, 9,  0
		  b"100011_10000_01010_0000000000000001", 	    -- lw   $t2, 1($s0)		x23, 16, 10, 1
		  b"100011_10000_01011_0000000000000010", 	    -- lw   $t3, 2($s0)		x23, 16, 11, 3
		  b"000000_01001_01010_01100_00000_100000", 	-- add  $t4, $t1, $t2	x00, 9,  10, 12, 0, x20
		 
 		  b"000000_01001_01010_01101_00000_100000", 	-- add  $t5, $t1, $t2	x00, 9,  10, 13, 0, x20
		  b"000100_01011_01100_0000000000000001", 	    -- beq  $t3, $t4, two	x04, 11, 12, 1
		  b"000000_01011_01100_01101_00000_100000",     -- add  $t5, $t3, $t4	x00, 11, 12, 13, 0, x20
		  b"101011_10000_01101_0000000000000100", 	    -- sw   $t5, 4($s0)		x2b, 16, 13, 4
		  
		  b"100011_10000_01110_0000000000000100", 	    -- lw   $t6, 4($s0)		x23, 16, 14, 1
		  
		  
		  -- testing program that tests all instructions
		  b"001000_00000_01011_0000000000000011", 		-- addi $t3, $0, 3
		  b"001000_00000_01101_0000000000000101", 		-- addi $t5, $0, 5
		  b"000000_01101_01011_01110_00000_100010", 	-- sub $t6, $t5, $t3
		  b"000000_01101_01011_01110_00000_100100", 	-- and $t6, $t5, $t3
 		  b"000000_01101_01011_01110_00000_100101", 	-- or $t6, $t5, $t3
		  b"000000_00000_01101_01110_00010_000000", 	-- sll $t6, $t5, 2
		  b"000000_00000_01101_01110_00001_000010", 	-- srl $t6, $t5, 1
		  b"000000_01011_01101_01110_00000_101010", 	-- slt $t6, $t3, $t5
		  
		  b"001101_01101_01110_0000000000010000", 		-- ori $t6, $t5, 16
		  b"001111_00000_01110_0000000000011111", 		-- lui $t6, 31
		  
		  b"001000_00000_01101_0000000000110000", 		-- addi $t5, $0, 48
		  b"000000_01101_00000_00000_00000_001000", 	-- jr $t5
		  
		  
		  
		               x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  
		  b"000011_00000000000000000000111110", 		-- jal 62
		  x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000",
		  b"000000_11111_00000_01110_00000_100000", 	-- add $t6, $ra, $0
		  x"00000000"
		);

	begin
	   process(clk, write_enable, address, data) 
	   begin
	       -- synchronous write
		  if rising_edge(clk) and write_enable = '1' then
			memory_array(to_integer(unsigned(address))) <= data;
		  end if;
		  -- asynchronous continuous read of the data memory location at address var_addr 
		  output <= memory_array(to_integer(unsigned(address)));
	end process;

end inst_arch;