----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 21:17:26
-- Design Name: 
-- Module Name: draw_paddle - Behavioral
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

entity draw_paddle is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           blank : in STD_LOGIC;
           paddle_h : in integer range 0 to 800;
           paddle_v : in integer range 0 to 800;
           rouge : out STD_LOGIC_VECTOR (3 downto 0);
           bleu : out STD_LOGIC_VECTOR (3 downto 0);
           vert : out STD_LOGIC_VECTOR (3 downto 0));
end draw_paddle;

architecture Behavioral of draw_paddle is

begin

    rouge <= "1111" when  blank='0' and ((hpos >= paddle_h and hpos < paddle_h + 5) and (vpos >= paddle_v and vpos < paddle_v + 40)) else "0000";
    bleu <= "1111" when  blank='0' and ((hpos >= paddle_h and hpos < paddle_h + 5) and (vpos >= paddle_v and vpos < paddle_v + 40)) else "0000";
    vert <= "1111" when  blank='0' and ((hpos >= paddle_h and hpos < paddle_h + 5) and (vpos >= paddle_v and vpos < paddle_v + 40)) else "0000";
end Behavioral;
