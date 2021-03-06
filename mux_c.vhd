----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:48:38 03/06/2016 
-- Design Name: 
-- Module Name:    mux_c - Behavioral 
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

entity mux_c is
    Port ( muxc : in  STD_LOGIC_VECTOR (1 downto 0);
           sp : in  STD_LOGIC_VECTOR (15 downto 0);
           adr : in  STD_LOGIC_VECTOR (15 downto 0);
           pc : in  STD_LOGIC_VECTOR (15 downto 0);
           ab : out  STD_LOGIC_VECTOR (15 downto 0));
end mux_c;

architecture Behavioral of mux_c is
begin
	ab <= 	sp	when muxc = "00" else
			adr	when muxc = "01" else
			pc	when muxc = "10" else
			"ZZZZZZZZZZZZZZZZ";
end Behavioral;

