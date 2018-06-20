----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 15:23:57
-- Design Name: 
-- Module Name: draw_dotline - Behavioral
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

entity draw_dotline is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           blank : in STD_LOGIC ;
           red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end draw_dotline;

architecture Behavioral of draw_dotline is
signal color : STD_LOGIC_VECTOR (3 downto 0):= "0000";
begin

color <= "1111" WHEN blank ='0' and hpos = 319 and vpos(2)='1'  and vpos <455 else "0000";
red <= color;
green <= color;
blue <= color;
end Behavioral;
