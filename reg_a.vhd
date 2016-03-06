----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:32 03/06/2016 
-- Design Name: 
-- Module Name:    reg_a - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_a is
    Port ( db : in  STD_LOGIC_VECTOR (7 downto 0);
           a_load : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           asr : in  STD_LOGIC;
           a : inout  STD_LOGIC_VECTOR (7 downto 0));
end reg_a;

architecture Behavioral of reg_a is
begin
	process (mclk)
	begin
		if (mclk'event and mclk = '1') then
			if (a_load = '0') then a <= db; end if;
			if (asr = '0') 	then a <= a(7) & a(7 downto 1); end if;		---asr here
		end if;
	end process;
end Behavioral;

