----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:31:20 03/05/2016 
-- Design Name: 
-- Module Name:    reg_pc - Behavioral 
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

entity reg_pc is
    Port ( pc_inc : in  STD_LOGIC;
           pc_reset : in  STD_LOGIC;
           pc_load : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           ab : in  STD_LOGIC_VECTOR (15 downto 0);
           pc : inout  STD_LOGIC_VECTOR (15 downto 0));
end reg_pc;

architecture Behavioral of reg_pc is
begin
	process (mclk, pc_inc, pc_reset, pc_load)
	variable temp : STD_LOGIC_VECTOR (2 downto 0);
	begin
		if (mclk'event and mclk = '1') then 
			temp := pc_inc & pc_reset & pc_load;
			case temp is
				when "011" =>	pc <= pc + 	"0000000000000001";
				when "101" =>	pc <= 		"0000000000000000";
				when "110" =>	pc <= ab;
				when others =>	pc <= pc;
			end case;
		end if;
	end process;
end Behavioral;

