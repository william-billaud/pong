----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.06.2018 10:21:29
-- Design Name: 
-- Module Name: dot - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dot is
Port (hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end dot;

architecture Behavioral of dot is

begin

red <= "0000";
green <= "1111" WHEN hpos = 319 and (vpos=463 or vpos =  467) else "0000";
blue <= "0000";
end Behavioral;
