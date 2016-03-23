----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:20:29 03/05/2016 
-- Design Name: 
-- Module Name:    reg_sp - Behavioral 
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

entity reg_sp is
    Port ( sp_inc : in  STD_LOGIC;
           sp_dec : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           sp : inout  STD_LOGIC_VECTOR (15 downto 0));
end reg_sp;

architecture Behavioral of reg_sp is
begin
	process (mclk, sp_inc, sp_dec)
	variable temp : STD_LOGIC_VECTOR (1 downto 0);
	begin
		if (mclk'event and mclk = '1') then
			temp := sp_inc& sp_dec;
			case temp is
				when "00" => 		sp <= 		"0111111111111111"; 				---reset sp to 0x7FFF
				when "01" =>		sp <= sp - 	"0000000000000001";
				when "10" =>		sp <= sp + 	"0000000000000001";
				when others =>		sp <= sp;
			end case;
		end if;
	end process;
end Behavioral;

