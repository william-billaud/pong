----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 11:09:29
-- Design Name: 
-- Module Name: RGB_controller - Behavioral
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

entity RGB_controller is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           blank : in STD_LOGIC;
           rouge : out STD_LOGIC_VECTOR (3 downto 0);
           vert : out STD_LOGIC_VECTOR (3 downto 0);
           bleu : out STD_LOGIC_VECTOR (3 downto 0);
           paddle_h1 : in integer range 0 to 800;
           paddle_v1 : in integer range 0 to 800;
           paddle_h2 : in integer range 0 to 800;
           paddle_v2 : in integer range 0 to 800;
           balle_h : in integer range 0 to 800;
           balle_v : in integer range 0 to 800);
end RGB_controller;

architecture Behavioral of RGB_controller is
component digit_screen is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           start_h , start_v : in integer range 0 to 800:= 15;
           number : in integer range 0 to 99;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal scoreJ1	: integer range 0 to 9:= 8;
signal  r , g , b: STD_LOGIC_VECTOR (3 downto 0):="0000";

begin
    
    digit1 : digit_screen port map(
       hpos => hpos,
       vpos => vpos,
       start_h => 15,
       start_v => 15,
       number => scoreJ1,
       red => r,
       green => g,
       blue => b);   
    
    
    rouge <="1111" when 
    (((hpos >= paddle_h1 and hpos < paddle_h1 + 3) and (vpos >= paddle_v1 and vpos < paddle_v1 + 40)) or 
    ((hpos >= paddle_h2 and hpos < paddle_h2 + 3) and (vpos >= paddle_v2 and vpos < paddle_v2 + 40)) or 
    (hpos <3 or vpos >476 or hpos > 636 or vpos < 3)) and blank = '0'
            else r;

    bleu <= "1111" when (((hpos >= balle_h and hpos < balle_h + 8) and (vpos >= balle_v and vpos < balle_v + 8)) or 
    (hpos <3 or vpos >476 or hpos > 636 or vpos < 3)) and blank = '0'
            else b;
    
    vert <= "1111" when  (hpos <3 or vpos >476 or hpos > 636 or vpos < 3) and blank = '0'
            else g;          

end Behavioral;
