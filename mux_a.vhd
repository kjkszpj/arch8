----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:06 03/06/2016 
-- Design Name: 
-- Module Name:    mux_a - Behavioral 
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

entity mux_a is
    Port ( muxa : in  STD_LOGIC;
           tmp : in  STD_LOGIC_VECTOR (7 downto 0);
           a : in  STD_LOGIC_VECTOR (7 downto 0);
           result_a : out  STD_LOGIC_VECTOR (7 downto 0));
end mux_a;

architecture Behavioral of mux_a is
signal mask : STD_LOGIC_VECTOR (7 downto 0);
begin
	result_a <= tmp	when muxa = '1' else
					a;
end Behavioral;

