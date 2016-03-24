----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:33 03/06/2016 
-- Design Name: 
-- Module Name:    mux_b - Behavioral 
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

entity mux_b is
    Port ( muxb   : in  STD_LOGIC_VECTOR (2 downto 0);
    		 io_query : in STD_LOGIC;
           alu    : in  STD_LOGIC_VECTOR (7 downto 0);
           pch    : in  STD_LOGIC_VECTOR (7 downto 0);
           pcl    : in  STD_LOGIC_VECTOR (7 downto 0);
           adrh   : in  STD_LOGIC_VECTOR (7 downto 0);
           adrl   : in  STD_LOGIC_VECTOR (7 downto 0);
		 krix   : in STD_LOGIC;
		 prix   : in STD_LOGIC;
           db     : out  STD_LOGIC_VECTOR (7 downto 0));
end mux_b;

architecture Behavioral of mux_b is
begin
	db <= 	alu	when muxb & io_query = "0001" else
			pch	when muxb & io_query = "0011" else
			pcl	when muxb & io_query = "0101" else
			adrh when muxb & io_query = "1001" else
			adrl when muxb & io_query = "1011" else
      		krix & "000000" & prix when muxb & io_query = "1110" else
			"ZZZZZZZZ";
end Behavioral;

