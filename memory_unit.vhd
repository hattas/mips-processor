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
		  b"100011_10000_01001_0000000000000000", 	-- lw   $t1, 0($s0)		x23, 16, 9,  0
		  b"100011_10000_01010_0000000000000001", 	-- lw   $t2, 1($s0)		x23, 16, 10, 1
		  b"100011_10000_01011_0000000000000010", 	-- lw   $t3, 2($s0)		x23, 16, 11, 3
		  b"000000_01001_01010_01100_00000_100000", 	-- add  $t4, $t1, $t2	x00, 9,  10, 12, 0, x20
		 
 		  b"000000_01001_01010_01101_00000_100000", 	-- add  $t5, $t1, $t2	x00, 9,  10, 13, 0, x20
		  b"000100_01011_01100_0000000000000001", 	-- beq  $t3, $t4, two	x04, 11, 12, 1
		  b"000000_01011_01100_01101_00000_100000", 	-- add  $t5, $t3, $t4	x00, 11, 12, 13, 0, x20
		  b"101011_10000_01101_0000000000000100", 	-- sw   $t5, 4($s0)		x2b, 16, 13, 4
		  
		  b"100011_10000_01110_0000000000000100", 	-- lw   $t6, 4($s0)		x23, 16, 14, 1
		  
		               x"00000000", x"00000000", x"00000000",
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

end inst_arch;