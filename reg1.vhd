----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:16:31 03/06/2016 
-- Design Name: 
-- Module Name:    reg1 - Behavioral 
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

entity reg1 is
    Port ( clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           x : in  STD_LOGIC_VECTOR (7 downto 0);
           r : inout  STD_LOGIC_VECTOR (7 downto 0));
end reg1;

architecture Behavioral of reg1 is
begin
	process (clk)
	begin
		if (clk'event and clk = '0') then
			if (load = '0') then r <= x;
			end if;
		end if;
	end process;
end Behavioral;

