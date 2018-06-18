----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.06.2018 22:27:59
-- Design Name: 
-- Module Name: digit - Behavioral
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit is
    Port ( number : in integer range 0 to 9;
           LedOut : out STD_LOGIC_VECTOR (6 downto 0));
end digit;

architecture Behavioral of digit is

begin 
    with number select LedOut <= 
        "0000001" when 0, -- "0"     
        "1001111" when 1, -- "1" 
        "0010010" when 2, -- "2" 
        "0000110" when 3, -- "3" 
        "1001100" when 4, -- "4" 
        "0100100" when 5, -- "5" 
        "0100000" when 6, -- "6" 
        "0001111" when 7, -- "7" 
        "0000000" when 8, -- "8"     
        "0000100" when 9, -- "9"
        "0000000" when others;
end Behavioral;
