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
           mclk : in  STD_LOGIC;
           a_load : in  STD_LOGIC;
           asr : in  STD_LOGIC;
			  a_clear : in  STD_LOGIC;
           a : inout  STD_LOGIC_VECTOR (7 downto 0));
end reg_a;

architecture Behavioral of reg_a is
begin
	process (mclk)
	variable temp : STD_LOGIC_VECTOR (2 downto 0);
	begin
		if (mclk'event and mclk = '0') then
			temp := (a_load, asr, a_clear);
			case temp is
				when "111" =>	a <= a;
				when "011" =>	a <= db;
				when "101" =>	a <= a(7) & a(7 downto 1);
				when "110" =>	a <= "00000000";
				when others =>	a <= a;
			end case;
		end if;
	end process;
end Behavioral;

