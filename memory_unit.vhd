-- register file
-- maybe use array of std_logic_vector?
-- use the address input to index into the array to get the data?


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

architecture arch of memory_unit is

		type MEM_ARRAY_64x32 is array(0 to 63) of std_logic_vector(31 downto 0);
		signal memory_array:MEM_ARRAY_64x32 :=(
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
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000"
		);
	   
--begin
	
	--data_mem_process: process (clk, write_enable, data, address) is
		--variable var_data : MEM_ARRAY_64x32;
		--variable var_address : integer;
	--begin
		--var_address := to_integer(unsigned(address(5 downto 0)));    
	--	if (reset = '1') then
			-- desired initial values of the data memory:
			--var_data(0)  := X"00000001";
			--GEN_REG: 
		--	for i in 1 to 31 generate
			--		var_data(1)  := X"00000000";
		--			var_data(2)  := X"00000000";
	--				var_data(3)  := X"00000000";
--					var_data(4)  := X"00000000";
					
					--var_data(5)  := X"00000000";
				--	var_data(6)  := X"00000000";
			--		var_data(7)  := X"00000000";
		--			var_data(8)  := X"00000000";
					
	--				var_data(9)  := X"00000000";
--					var_data(10)  := X"00000000";
					--var_data(11)  := X"00000000";
				--	var_data(12)  := X"00000000";
					
			--		var_data(13)  := X"00000000";
		--			var_data(14)  := X"00000000";
	--				var_data(15)  := X"00000000";
--					var_data(16)  := X"00000000";
					
					--var_data(17)  := X"00000000";
				--	var_data(18)  := X"00000000";
			--		var_data(19)  := X"00000000";
		--			var_data(20)  := X"00000000";
					
	--				var_data(21)  := X"00000000";
--					var_data(22)  := X"00000000";
					--var_data(23)  := X"00000000";
				--	var_data(24)  := X"00000000";
					
			--		var_data(25)  := X"00000000";
		--			var_data(26)  := X"00000000";
	--				var_data(27)  := X"00000000";
--					var_data(28)  := X"00000000";
					
					--var_data(29)  := X"00000000";
				--	var_data(30)  := X"00000000";
			--		var_data(31)  := X"00000000";
		--			var_data(32)  := X"00000000";
					
	--				var_data(33)  := X"00000000";
--					var_data(34)  := X"00000000";
					--var_data(35)  := X"00000000";
				--	var_data(36)  := X"00000000";
					
			--		var_data(37)  := X"00000000";
		--			var_data(38)  := X"00000000";
	--				var_data(39)  := X"00000000";
--					var_data(40)  := X"00000000";
					
					--var_data(41)  := X"00000000";
				--	var_data(42)  := X"00000000";
			--		var_data(43)  := X"00000000";
		--			var_data(44)  := X"00000000";
					
	--				var_data(45)  := X"00000000";
--					var_data(46)  := X"00000000";
				--	var_data(47)  := X"00000000";
			--		var_data(48)  := X"00000000";
					
		--			var_data(49)  := X"00000000";
	--				var_data(50)  := X"00000000";
--					var_data(51)  := X"00000000";
				--	var_data(52)  := X"00000000";
					
			--		var_data(53)  := X"00000000";
		--			var_data(54)  := X"00000000";
	--				var_data(55)  := X"00000000";
--					var_data(56)  := X"00000000";
					
					--var_data(57)  := X"00000000";
					--var_data(58)  := X"00000000";
					--var_data(59)  := X"00000000";
					--var_data(60)  := X"00000000";
					
				--	var_data(61)  := X"00000000";
				--	var_data(62)  := X"00000000";
				--	var_data(63)  := X"00000000";
															
                   
			--end generate GEN_REG;
	begin
	   process(clk, write_enable, address, data) 
	   begin		
		if (rising_edge(clk)) then
		  if( write_enable = '1') then
			-- synchronous rdata mem write should be done on falling edge
			--var_data(var_address) := data;
			memory_array(to_integer(unsigned(address))) <= data;
		  end if;
		-- asynchronous continuous read of the data memory location at address var_addr 
		      output <= memory_array(to_integer(unsigned(address)));
		  end if;
		--end if;
	end process;

end arch;