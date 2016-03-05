----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:41:34 03/05/2016 
-- Design Name: 
-- Module Name:    cpu_main - Behavioral 
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

entity cpu_main is
    Port ( ab : inout  STD_LOGIC_VECTOR (31 downto 0);
           db : inout  STD_LOGIC_VECTOR (31 downto 0);
           cb : inout  STD_LOGIC_VECTOR (31 downto 0);
           co : out  STD_LOGIC_VECTOR (31 downto 0);
           ci : in  STD_LOGIC_VECTOR (31 downto 0));
end cpu_main;

architecture Behavioral of cpu_main is

begin


end Behavioral;

