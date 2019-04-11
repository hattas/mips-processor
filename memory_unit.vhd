-- register file
-- maybe use array of std_logic_vector?
-- use the address input to index into the array to get the data?


library IEEE;
use IEEE.std_logic_1164.all;

entity memory_unit is
	port(
		reset: in std_logic;
		clk: in std_logic;
		address: in std_logic_vector(5 downto 0);
		data: in std_logic_vector(31 downto 0);
		write_enable, clock: in std_logic;
		output: out std_logic_vector(31 downto 0);
	);
end memory_unit;

architecture arch of memory_unit is

		type MEM_ARRAY_64x32 is array(0 to 64) of std_logic_vector(31 downto 0);
	
begin
	
	data_mem_process: process (clk, write_enable, data, address) is
		variable var_data : MEM_ARRAY_64x32;
		variable var_address : integer;
	begin
		var_address := conv_integer(address(5 downto 0));    
		if (reset = '1') then
			-- desired initial values of the data memory:
			var_data(0)  := X"0001";
			GEN_REG:
				for i in 1 to 31 generate
					var_data(i)  := X"0000";
			end generate GEN_REG
		elsif (rising_edge(clk) and write_enable = '1') then
			-- synchronous rdata mem write should be done on falling edge?
			var_data(var_address) := data;
		end if;
	 
		-- asynchronous continuous read of the data memory location at address var_addr 
		output <= var_data(var_address);
		
	end process;

end memory_unit;