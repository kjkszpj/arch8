----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:08 03/06/2016 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           cin : in  STD_LOGIC;
           m : in  STD_LOGIC;
           s : in  STD_LOGIC_VECTOR (1 downto 0);
           result : out  STD_LOGIC_VECTOR (7 downto 0);
           cout : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
signal result_a : STD_LOGIC_VECTOR (8 downto 0);
signal result_l : STD_LOGIC_VECTOR (7 downto 0);
signal mask : STD_LOGIC_VECTOR (7 downto 0);
begin
	result_l <= a when s = "00" else
					b when s = "01" else
					a or b when s = "10" else
					not b when s = "11" else
					"00000000";
					
	result_a <= ("0" & a) + ("0" & b) when s = "00" else
					("0" & a) - ("0" & b) when s = "01" else
					("0" & a) + ("0" & b) + ("00000000" & cin) when s = "10" else
					"000000000";
	
	result <= 	result_a(7 downto 0) when m = '1' else
					result_l;
	cout <= result_a(8);
end Behavioral;

