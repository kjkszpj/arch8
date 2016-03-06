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
           r : out  STD_LOGIC_VECTOR (7 downto 0));
end regs;

architecture Behavioral of regs is
signal r0 : STD_LOGIC_VECTOR (7 downto 0);
signal r1 : STD_LOGIC_VECTOR (7 downto 0);
signal r2 : STD_LOGIC_VECTOR (7 downto 0);
signal r3 : STD_LOGIC_VECTOR (7 downto 0);
signal ri : STD_LOGIC_VECTOR (7 downto 0);
signal rj : STD_LOGIC_VECTOR (7 downto 0);
signal mask : STD_LOGIC_VECTOR (7 downto 0);
begin
	---load logic, always load to ri.
	process (mclk)
	begin
		if (mclk'event and mclk = '1') then
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
	
	---read ri logic
	process (i, r0, r1, r2, r3)
	begin
		case i is
			when "00" =>	ri <= r0;
			when "01" =>	ri <= r1;
			when "10" =>	ri <= r2;
			when others =>	ri <= r3;
		end case;
	end process;
	
	---read ri logic
	process (j, r0, r1, r2, r3)
	begin
		case j is
			when "00" =>	rj <= r0;
			when "01" =>	rj <= r1;
			when "10" =>	rj <= r2;
			when others =>	rj <= r3;
		end case;
	end process;
	
	mask <= (needj, needj, needj, needj, needj, needj, needj, needj);
	r <= (ri and mask) or (rj and not mask);
end Behavioral;
