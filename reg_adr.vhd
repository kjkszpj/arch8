----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:13 03/05/2016 
-- Design Name: 
-- Module Name:    reg_adr - Behavioral 
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

entity reg_adr is
    Port ( mclk : in  STD_LOGIC;
			  db : in  STD_LOGIC_VECTOR (7 downto 0);
           adrh_load : in  STD_LOGIC;
           adrl_load : in  STD_LOGIC;
           ahs : in  STD_LOGIC;
           adrh : inout  STD_LOGIC_VECTOR (7 downto 0);
           adrl : inout  STD_LOGIC_VECTOR (7 downto 0));
end reg_adr;

architecture Behavioral of reg_adr is
begin
	---	for adrh, 0b01111110 = 0x7E
	process (mclk, adrh_load, ahs)
	variable temp : STD_LOGIC_VECTOR(1 downto 0);
	begin
		if (mclk'event and mclk = '1') then
			temp := adrh_load & ahs;
			case temp is
				when "01" =>	adrh <= db;
				when "10" => 	adrh <= "01111110";
				when others =>	adrh <= adrh;
			end case;
		end if;
	end process;
	
	---	for adrl
	process (mclk, adrl_load)
	begin
		if (mclk'event and mclk = '1') then 
			case (adrl_load) is
				when '0' =>		adrl <= db;
				when others => adrl <= adrl;
			end case;
		end if;
	end process;
end Behavioral;

