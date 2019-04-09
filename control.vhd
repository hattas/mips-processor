
-- control unit

library IEEE;
use IEEE.std_logic_1164.all;

entity control is
	port(
		instruction: in std_logic_vector(5 downto 0);
		regdst: out std_logic_vector(31 downto 0);
		jump: out std_logic;
		branch: out std_logic;
		memread: out std_logic;
		memtoreg: out std_logic;
		aluop: out std_logic_vector(1 downto 0);
		memwrite: out std_logic;
		alusrc: out std_logic;
		regwrite: out std_logic;
	);
end control;

architecture arch of control is
begin

process(instruction)
begin
	-- R type
	if instruction = "000000" then
		regdst <= '1';
		jump <= '0';
		branch <= '0';
		memread <= '0';
		memtoreg <= '0';
		aluop <= "10";
		memwrite <= '0';
		alusrc <= '0';
		regwrite <= '1';
	-- lw
	elsif instruction = "100011" then
		regdst <= '0';
		jump <= '0';
		branch <= '0';
		memread <= '1';
		memtoreg <= '1';
		aluop <= "00";
		memwrite <= '0';
		alusrc <= '1';
		regwrite <= '1';
	-- sw
	elsif instruction = "101011" then
		--regdst <= 'X';
		jump <= '0';
		branch <= '0';
		memread <= '0';
		--memtoreg <= 'X';
		aluop <= "00";
		memwrite <= '1';
		alusrc <= '1';
		regwrite <= '0';
	-- beq
	elsif instruction = "000100" then
		--regdst <= 'X';
		jump <= '0';
		branch <= '1';
		memread <= '0';
		--memtoreg <= 'X';
		aluop <= "01";
		memwrite <= '0';
		alusrc <= '0';
		regwrite <= '0';
	-- addi
	elsif instruction = "001000" then
		regdst <= '0';
		jump <= '0';
		branch <= '0';
		memread <= '0';
		memtoreg <= '0';
		aluop <= "10"; -- addition, check
		memwrite <= '0';
		alusrc <= '1';
		regwrite <= '1';
	-- ori
	elsif instruction = "001101" then
		regdst <= '0';
		jump <= '0';
		branch <= '0';
		memread <= '0';
		memtoreg <= '0';
		aluop <= "00"; -- or, check
		memwrite <= '0';
		alusrc <= '1';
		regwrite <= '1';
	end if;
end process;
	

end alu;