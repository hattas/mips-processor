----------------------------------------------------------------------------------
--
-- file: control.vhd
-- authors: Kyle Chang, John Hattas, Patrick Woodford
-- created: 4/9/19
-- description: This is the top level control unit.
-- 		It takes in the function and op code and returns all control signals.
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity control is
	port(
		opcode: in std_logic_vector(5 downto 0);
		funct: in std_logic_vector(5 downto 0);
		
		regdst: out std_logic_vector(1 downto 0);
		jump: out std_logic;
		branch: out std_logic;
		memread: out std_logic;
		regdatasel: out std_logic_vector(1 downto 0);
		aluop: out std_logic_vector(1 downto 0);
		memwrite: out std_logic;
		alusrca: out std_logic;
		alusrcb: out std_logic;
		regwrite: out std_logic;
		jumpreg: out std_logic
	);
end control;

architecture arch of control is
	signal r_type : std_logic := '0';
begin

	process(opcode, funct, r_type)
	begin
		if opcode = "000000" then
			r_type <= '1';
		else
			r_type <= '0';
		end if;
		
		if r_type = '1' then
			regdst <= "01";
		elsif opcode = "000011" then
			regdst <= "10";
		else
			regdst <= "00";
		end if;
		
		if (r_type = '1' and funct = "001000") or opcode = "000011" then
			jump <= '1';
		else
			jump <= '0';
		end if;
		
		if opcode = "000100" then
			branch <= '1';
		else
			branch <= '0';
		end if;
		
		
		if opcode = "100011" then
			memread <= '1';
		else
			memread <= '0';
		end if;
		
		if opcode = "001111" then
			regdatasel <= "10";
		elsif opcode = "100011" then
			regdatasel <= "01";
		elsif opcode = "000011" then
			regdatasel <= "11";
		else
			regdatasel <= "00";
		end if;
		
		if opcode = "001101" then
			aluop <= "11";
		elsif opcode = "001000" then
			aluop <= "00";
		elsif opcode = "000100" then
			aluop <= "01";
		else
			aluop <= "10";
		end if;
		
		if opcode = "101011" then
			memwrite <= '1';
		else
			memwrite <= '0';
		end if;
		
		if r_type = '1' and (opcode = "000000" or opcode = "000010") then
			alusrca <= '1';
		else
			alusrca <= '0';
		end if;
		
		if opcode = "001000" or opcode = "001101" then
			alusrcb <= '1';
		else
			alusrcb <= '0';
		end if;
		
		if opcode = "101011" or opcode = "000100" or opcode = "000011" then
			regwrite <= '0';
		else
			regwrite <= '1';
		end if;
		
		if r_type = '1' and funct = "001000" then
			jumpreg <= '1';
		else
			jumpreg <= '0';
		end if;
		
	end process;
	
end arch;
