----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:39 03/06/2016 
-- Design Name: 
-- Module Name:    reg_act - Behavioral 
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

entity reg_act is
    Port ( mclk : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR (7 downto 0);
           act : out  STD_LOGIC_VECTOR (7 downto 0);
           act_load : in  STD_LOGIC);
end reg_act;

architecture Behavioral of reg_act is
begin
	process (mclk)
	begin
		if (mclk'event and mclk = '1') then
			if (act_load = '0') then act <= a;
			end if;
		end if;
	end process;
end Behavioral;

