----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:17:53 03/06/2016 
-- Design Name: 
-- Module Name:    regs - Behavioral 
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

entity regs is
    Port ( reg_load : in  STD_LOGIC;
           ri : in  STD_LOGIC_VECTOR (1 downto 0);
           mclk : in  STD_LOGIC;
           db : in  STD_LOGIC_VECTOR (7 downto 0);
           r : out  STD_LOGIC_VECTOR (7 downto 0));
end regs;

architecture Behavioral of regs is
signal r0 : STD_LOGIC_VECTOR (7 downto 0);
signal r1 : STD_LOGIC_VECTOR (7 downto 0);
signal r2 : STD_LOGIC_VECTOR (7 downto 0);
signal r3 : STD_LOGIC_VECTOR (7 downto 0);
begin
	process (mclk, reg_load, ri, db)
	begin
		if (mclk'event and mclk = '1') then
			if (reg_load = '0') then
				case ri is
					when "00" =>	r0 <= db;
					when "01" =>	r1 <= db;
					when "10" =>	r2 <= db;
					when others =>	r3 <= db;
				end case;
			end if;
		end if;
	end process;
	
	process (ri, r0, r1, r2, r3)
	begin
		case ri is
			when "00" =>	r <= r0;
			when "01" =>	r <= r1;
			when "10" =>	r <= r2;
			when others =>	r <= r3;
		end case;
	end process;
end Behavioral;

