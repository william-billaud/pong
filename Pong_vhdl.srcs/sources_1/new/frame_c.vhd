----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 10:39:01
-- Design Name: 
-- Module Name: frame_c - Behavioral
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

entity frame_c is
    Port ( hpos : in std_logic_vector(10 downto 0);
           vpos : in std_logic_vector(10 downto 0);
           in_progress : in std_logic;
           new_frame : out STD_LOGIC);
end frame_c;

architecture Behavioral of frame_c is
signal f : std_logic;
begin
new_frame <= '1' WHEN (hpos = 0 and vpos = 0 and in_progress ='1') else '0';

end Behavioral;
