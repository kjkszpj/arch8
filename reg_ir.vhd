----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date:    21:00:41 03/05/2016 
-- Design Name: 
-- Module Name:    reg_ir - Behavioral 
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

entity reg_ir is
    Port ( db : in  STD_LOGIC_VECTOR (7 downto 0);
           ir_load : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           ir : inout  STD_LOGIC_VECTOR (7 downto 0));
end reg_ir;

architecture Behavioral of reg_ir is
begin
	process (ir_load, mclk)
	begin
		if (mclk'event and mclk = '1') then
			if (ir_load = '0') 	then ir <= db;
										else ir <= ir;
			end if;
		end if;
	end process;
end Behavioral;

