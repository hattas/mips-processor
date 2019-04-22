-- alu testbench
-- tests all combinations of ALUOp and functions with various inputs
-- tests edge cases for overlow and carry with add/subtract

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
--  Port ( );
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
        b_s <= x"23492748";
        wait for 10 ns;
        
           
    end process;
end Behavioral;
