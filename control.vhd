
-- control unit

library IEEE;
use IEEE.std_logic_1164.all;

entity control is
	port(
		instruction: in std_logic_vector(5 downto 0);
		regdst: out std_logic_vector(1 downto 0);
		jump: out std_logic;
		branch: out std_logic;
		memread: out std_logic;
		memtoreg: out std_logic_vector(1 downto 0);
		aluop: out std_logic_vector(1 downto 0);
		memwrite: out std_logic;
		alusrc: out std_logic;
		regwrite: out std_logic;
		luiwrite: out std_logic;
		funct: in std_logic_vector(5 downto 0)
	);
end control;

architecture arch of control is
begin

process(instruction)
begin
    regdst <= "00";
    jump <= '0';
    branch <= '0';
    memread <='0';
    memtoreg <= "00";
    aluop <= "00";
    memwrite <= '0';
    alusrc <= '0';
    regwrite <= '0';
    luiwrite <= '0';
    
    
    
    luiwrite <= '0';
	-- R type
	if instruction = "000000" then
	   if funct = "001000" then
	       regdst <= "XX";
	       jump <= '1';
	       memtoreg <= "XX";
	       aluop <= "XX";
	       regwrite <= '1';
	    else   
		  regdst <= "01";
		  aluop <= "10";
		  regwrite <= '1';
		end if;
	-- lw
	elsif instruction = "100011" then
		regdst <= "00";
		memread <= '1';
		memtoreg <= "01";
		alusrc <= '1';
		regwrite <= '1';
	-- sw
	elsif instruction = "101011" then
		regdst <= "XX";
		memtoreg <= "XX";
		memwrite <= '1';
		alusrc <= '1';
	-- beq
	elsif instruction = "000100" then
		regdst <= "XX";
		branch <= '1';
		memtoreg <= "XX";
		aluop <= "01";
	-- addi
	elsif instruction = "001000" then
		aluop <= "10"; -- addition, check
		alusrc <= '1';
		regwrite <= '1';
	-- ori
	elsif instruction = "001101" then
		alusrc <= '1';
		regwrite <= '1';
    --jal
    elsif instruction = "000011" then
        regdst <= "10";
        jump <= '1';
        branch <= 'X';
        memtoreg <= "10";
        aluop <= "XX";
        alusrc <= 'X';
        regwrite <= '1';
     --lui
     elsif instruction = "001111" then
        luiwrite <= '1';
        memread <= 'X';
        aluop <= "11";
        alusrc <= '1';
        regwrite <= '1';
	end if;
end process;
	

end arch;