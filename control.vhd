
-- control unit

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
		regwrite: out std_logic
	);
end control;

architecture arch of control is
	signal r_type : std_logic := '0';
begin

	process(opcode, funct)
	begin
		r_type <= '1' when opcode = "000000" else '0';
		
		regdst <= "01" when r_type = '1' else
				  "10" when opcode = "000011" else
				  "00";
		
		jump <= '1' when r_type = '1' and funct = "001000" else
				'1' when opcode = "000011" else
				'0';
		
		branch <= '1' when opcode = "000100" else '0';
		
		memread <= '1' when opcode = "100011" else '0';
		
		regdatasel <= "10" when opcode = "001111" else
		              "01" when opcode = "100011" else
					  "11" when opcode = "000011" else
					  "00";
		
		aluop <= "11" when opcode = "001101" else
				 "00" when opcode = "001000" else
				 "01" when opcode = "000100" else
				 "10";
				 
		memwrite <= '1' when opcode = "101011" else '0';
		
		alusrca <= '1' when r_type = '1' and (opcode = "000000" or opcode = "000010") else
				   '0';
		
		alusrcb <= '1' when opcode = "001000" else
				   '1' when opcode = "001101" else
				   '0';
		
		regwrite <= '0' when opcode = "101011" else
					'0' when opcode = "000100" else
					'0' when opcode = "000011" else
					'1';
	end process;
	
end arch;
