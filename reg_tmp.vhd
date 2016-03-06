----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:27 03/06/2016 
-- Design Name: 
-- Module Name:    reg_tmp - Behavioral 
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

entity reg_tmp is
    Port ( db : in  STD_LOGIC_VECTOR (7 downto 0);
           mclk : in  STD_LOGIC;
           tmp_load : in  STD_LOGIC;
           tmp : out  STD_LOGIC_VECTOR (7 downto 0));
end reg_tmp;

architecture Behavioral of reg_tmp is
begin
	process (mclk)
	begin
		if (mclk'event and mclk = '1') then
			if (tmp_load = '0') then tmp <= db; end if;
		end if;
	end process;
end Behavioral;

