----------------------------------------------------------------------------------
--
-- File: register_file_tb.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/21/19
-- Description: This is the testbench for the register file.
-- 		We write and read to various registers to ensure proper operation.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_file_tb is
--  Port ( );
end register_file_tb;

architecture arch of register_file_tb is    
	signal clock_s : std_logic := '0'; -- make sure you initialise!
	constant half_period : time := 1 ns; -- 2 ns period
	signal write_enable_s : std_logic;
    signal read_reg1_s, read_reg2_s, write_reg_s : std_logic_vector(4 downto 0);
    signal write_data_s : std_logic_vector(31 downto 0);
    signal read_data1_s, read_data2_s : std_logic_vector(31 downto 0);
begin
	clock_s <= not clock_s after 1 ns;
	
	UUT: entity work.register_file port map(clock=>clock_s, write_enable=>write_enable_s,
											read_reg1=>read_reg1_s, read_reg2=>read_reg2_s, write_reg=>write_reg_s,
											write_data=>write_data_s, read_data1=>read_data1_s, read_data2=>read_data2_s);
    process
    begin
		
		-- initialize registers
		write_enable_s <= '0';
		read_reg1_s <= (others => '0');
		read_reg2_s <= (others => '0');
		write_reg_s <= (others => '0');
		write_data_s <= (others => '0');
        wait for 10 ns;
        
        -- write to register 0
        -- read reg 1 and 2 should asynchronously output the written value
        write_enable_s <= '1';
        write_data_s <= x"12345678";
        wait for 10 ns;
        
        -- write to register 31
        write_enable_s <= '1';
        write_reg_s <= "11111";
        write_data_s <= x"98765432";
        wait for 10 ns;
        
        -- read from register 1 to register 2
        write_enable_s <= '0';
        read_reg1_s <= "00101";
        read_reg2_s <= "11111";
        wait for 10 ns;
           
    end process;
end arch;
