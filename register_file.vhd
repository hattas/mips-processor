-- register file

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
    port (
        clock, write_enable : in std_logic;
        read_reg1, read_reg2, write_reg : in std_logic_vector(4 downto 0);
        write_data : in std_logic_vector(31 downto 0);
        read_data1, read_data2 : out std_logic_vector(31 downto 0)
    );
end register_file;

architecture arch of register_file is
    type REG_ARRAY_32x32 is array(0 to 31) of std_logic_vector(31 downto 0);
begin
    register_mem_process : process (clock, write_enable, read_reg1, read_reg2, write_reg, write_data) is
		variable var_data : REG_ARRAY_32x32 := (  
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000",
		  x"00000000", x"00000000", x"00000000", x"00000000"
		);
        variable var_write_reg : integer;
        variable var_read_reg1 : integer;
        variable var_read_reg2 : integer;
    begin
        -- convert register indices to integers
        var_write_reg := to_integer(unsigned(write_reg));
        var_read_reg1 := to_integer(unsigned(read_reg1));
        var_read_reg2 := to_integer(unsigned(read_reg2));
 
        if rising_edge(clock) and write_enable = '1' then
            var_data(var_write_reg) := write_data;
        end if;
        -- asynchronous continuous read of the data memory location at address var_addr
        read_data1 <= var_data(var_read_reg1);
        read_data2 <= var_data(var_read_reg2);
    end process;

end arch;