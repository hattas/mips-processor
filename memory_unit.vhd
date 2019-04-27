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
		  x"00000001", x"00000002", x"00000000", x"00000004",
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
		  x"8e090000", -- lw   $t1, 0($s0)
		  x"8e0a0001", -- lw   $t2, 1($s0)
		  x"8e0b0003", -- lw   $t3, 3($s0)
		  x"012a6020", -- add  $t4, $t1, $t2 #t4 = t1 + t2
		  x"012a6820", -- add  $t5, $t1, $t2 #t5 = t1 + t2
		  x"116cfffc", -- beq  $t3, $t4, two # branch if t1 + t2 = t3
		  x"016c6820", -- add  $t5, $t3, $t4 # t5 = t3 + t4 = t1 + t2 + t3
		  x"ae0d0004", -- sw   $t5, 4($s0)
		  x"8e0e0004", -- lw   $t6, 4($s0)
		  
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