-- clk_divider.vhd
-- This is a clock divider. It takes as input a signal
-- of 100 MHz and generates an output as signal with a frequency
-- of about 1 Hz.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity clk_divider is
  Port ( 
    TIMECONST : integer; -- 100000000/(84^4)/2
    CLK_IN : in STD_LOGIC;
    CLK_OUT : out STD_LOGIC
  );
end clk_divider;

architecture Behavioral of clk_divider is

signal count0, count1, count2, count3 : integer range 0 to 1000;
signal D : std_logic := '0';
begin

process (CLK_IN, D)
begin
	if (CLK_IN'event and CLK_IN = '1') then
		count0 <= count0 + 1;
		if count0 = TIMECONST then
			count0 <= 0;
			count1 <= count1 + 1;
		elsif count1 = TIMECONST then
			count1 <= 0;
			count2 <= count2 + 1;
		elsif count2 = TIMECONST then
			count2 <= 0;
			count3 <= count3 + 1;
		elsif count3 = TIMECONST then
			count3 <= 0;
			D <= not D;
		end if;
	end if;
	CLK_OUT <= D;
end process;

end Behavioral;
