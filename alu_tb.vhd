----------------------------------------------------------------------------------
--
-- File: alu_tb.vhd
-- Authors: Kyle Chang, John Hattas, Patrick Woodford
-- Created: 4/21/19
-- Description: This is the testbench for the alu.
-- 		We test every combination of aluop and funccode with many inputs and edge cases for each.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is    
    signal aluop_s:  std_logic_vector(1 downto 0);
    signal funccode_s:  std_logic_vector(5 downto 0);
    signal a_s, b_s: std_logic_vector(31 downto 0);
    signal result_s:  std_logic_vector(31 downto 0);
    signal overflow_s, zeroflag_s, carryout_s:  std_logic;
begin
UUT: entity work.alu port map(aluop=>aluop_s, funccode=>funccode_s, a=>a_s,
                              b=>b_s, result=>result_s, overflow=>overflow_s,
                              zeroflag=>zeroflag_s, carryout=>carryout_s);
    process
    begin
        
        
        -- opcode 00 add section
        funccode_s <= "------";
        aluop_s <= "00";
        
        -- add zero test
        a_s <= x"00000000";
        b_s <= x"00000000";
        wait for 10 ns;
        -- add general test no carry out
        a_s <= x"00010010";
        b_s <= x"00011000";
        wait for 10 ns;
        -- no overflow, carry out
        a_s <= x"FFFFFFFF"; -- -1
        b_s <= x"00000001"; -- 1
        wait for 10 ns;
        -- overflow and carry out
        a_s <= x"80000000";
        b_s <= x"80000000";
        wait for 10 ns;
        -- no overflow no nothing
        a_s <= x"0FFFFFFF";
        b_s <= x"00000001";
        wait for 10 ns;
        -- overflow no carry out
        a_s <= x"40000000";
        b_s <= x"40000000";
        wait for 10 ns;
        
        -- op 01 subtraction
        aluop_s <= "01";
        
        a_s <= x"00000002";
        b_s <= x"00000001";
        wait for 10 ns;
        a_s <= x"00000001";
        b_s <= x"00000001";
        wait for 10 ns;
        a_s <= x"FFFFFFFF";
        b_s <= x"FFFFFFFF";
        wait for 10 ns;
        a_s <= x"F4873ABC";
        b_s <= x"10932498";
        wait for 10 ns;
        
        -- op 11 - used for or immediate
        aluop_s <= "11";
        
        a_s <= x"00000002";
        b_s <= x"00000001";
        wait for 10 ns;
        a_s <= x"9123F302";
        b_s <= x"11111111";
        wait for 10 ns;
        a_s <= x"F4873ABC";
        b_s <= x"10932498";
        wait for 10 ns;
        
        -- R type section
        aluop_s <= "10";
        
        -- R type addition
        funccode_s <= "100000";
        
        a_s <= x"00010010";
        b_s <= x"00011000";
        wait for 10 ns;
        a_s <= x"FFFFFFFF"; -- -1
        b_s <= x"00000001"; -- 1
        wait for 10 ns;
        
        -- R type subtraction
        funccode_s <= "100010";
        
        a_s <= x"00000002";
        b_s <= x"00000001";
        wait for 10 ns;
        a_s <= x"00000001";
        b_s <= x"00000001";
        wait for 10 ns;
        a_s <= x"FFFFFFFF";
        b_s <= x"FFFFFFFF";
        wait for 10 ns;
        a_s <= x"F4873ABC";
        b_s <= x"10932498";
        wait for 10 ns;
        
        -- R type  and
        funccode_s <= "100100";
        
        a_s <= x"01101011";
        b_s <= x"10111000";
        wait for 10 ns;
        
        -- R type  or
        funccode_s <= "100101";
        
        a_s <= x"01101011";
        b_s <= x"10111000";
        wait for 10 ns;
        
        -- R type  slt
        funccode_s <= "101010";
        
        a_s <= x"00000001";
        b_s <= x"00000000";
        wait for 10 ns;
        
        a_s <= x"00000000";
        b_s <= x"00000001";
        wait for 10 ns;
        
        a_s <= x"18347938";
        b_s <= x"43492748";
        wait for 10 ns;
		
		-- overflow positive - negative
		a_s <= x"78347938";
        b_s <= x"f0000048";
        wait for 10 ns;
		
		-- overflow negative - positive
		a_s <= x"f0000048";
        b_s <= x"70192384";
        wait for 10 ns;
        
        -- R type SLL
        -- shifts b left by a
        funccode_s <= "000000";
        
        -- shift left by 1
        a_s <= x"00000001";
        b_s <= x"FDB97531";
        wait for 10 ns;
        
        -- shift left by 2
        a_s <= x"00000002";
        b_s <= x"FDB97531";
        wait for 10 ns;
        
        -- shift left by 16
        a_s <= x"00000010";
        b_s <= x"FDB97531";
        wait for 10 ns;
        
        -- R type SRL
        -- shifts b right by a
        funccode_s <= "000010";
        
        -- shift right by 1
        a_s <= x"00000001";
        b_s <= x"FDB97531";
        wait for 10 ns;
        
        -- shift right by 2
        a_s <= x"00000002";
        b_s <= x"FDB97531";
        wait for 10 ns;
        
        -- shift right by 16
        a_s <= x"00000010";
        b_s <= x"FDB97531";
        wait for 10 ns;
        
           
    end process;
end Behavioral;
