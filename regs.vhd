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
           needj : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR (1 downto 0);
           j : in  STD_LOGIC_VECTOR (1 downto 0);
           db : in  STD_LOGIC_VECTOR (7 downto 0);
           r : out  STD_LOGIC_VECTOR (7 downto 0);
			  r0 : inout  STD_LOGIC_VECTOR (7 downto 0);
			  r1 : inout  STD_LOGIC_VECTOR (7 downto 0);
			  r2 : inout  STD_LOGIC_VECTOR (7 downto 0);
			  r3 : inout  STD_LOGIC_VECTOR (7 downto 0));
end regs;

architecture Behavioral of regs is
signal ri : STD_LOGIC_VECTOR (7 downto 0);
signal rj : STD_LOGIC_VECTOR (7 downto 0);
begin
	---load logic, always load to ri.
	process (mclk)
	begin
		if (mclk'event and mclk = '0') then
			if (reg_load = '0') then
				case i is
					when "00" =>	r0 <= db;
					when "01" =>	r1 <= db;
					when "10" =>	r2 <= db;
					when others =>	r3 <= db;
				end case;
			end if;
		end if;
	end process;
	
	ri <= r0	when i = "00" else
			r1 when i = "01" else
			r2 when i = "10" else
			r3;
	
	rj <= r0	when j = "00" else
			r1 when j = "01" else
			r2 when j = "10" else
			r3;
	
	r <= 	rj when needj = '0' else
			ri;
end Behavioral;

