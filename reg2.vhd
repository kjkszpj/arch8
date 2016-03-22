----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:48:22 03/06/2016 
-- Design Name: 
-- Module Name:    reg2 - Behavioral 
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

entity reg2 is
    Port ( clk : in  STD_LOGIC;
           inc : in  STD_LOGIC;
           dec : in  STD_LOGIC;
           load : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           x : in  STD_LOGIC_VECTOR (15 downto 0);
			  y : in  STD_LOGIC_VECTOR (15 downto 0);
           r : inout  STD_LOGIC_VECTOR (15 downto 0));
end reg2;

architecture Behavioral of reg2 is
begin
	process (clk)
	variable temp : STD_LOGIC_VECTOR (2 downto 0);
	begin
		if (reset = '0') then r <= y;
		elsif (clk'event and clk = '0') then
			temp := (inc, dec, load);
			case temp is
				when "111" => 	r <= r;
				when "011" =>		r <= r + "0000000000000001";	---TODO: what about carry?
				when "101" =>		r <= r - "0000000000000001";	---TODO: what about carry?
				when "110" =>		r <= x;
				when others =>		r <= r;
			end case;
		end if;
	end process;
end Behavioral;

