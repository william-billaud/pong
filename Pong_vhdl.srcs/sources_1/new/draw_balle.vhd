----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 06:17:31
-- Design Name: 
-- Module Name: draw_balle - Behavioral
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

entity draw_balle is
     Port (hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           start_h , start_v : in integer range 0 to 800:= 15;
           red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end draw_balle;

architecture Behavioral of draw_balle is

begin

    process(hpos , vpos,start_h,start_v)      
        begin
        red <="0000";
        green <="0000";
        blue <="0000";
        if(hpos = start_h) then
            if(vpos > start_v+2 and vpos < start_v+5) then
                red <= "1111";
                green <="1111";
                blue <= "1111";
             end if;
        elsif(hpos = start_h +1) then
             if(vpos > start_v and vpos < start_v+7) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
        elsif(hpos = start_h +2 ) then
             if(vpos > start_v and vpos < start_v+7) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
        elsif(hpos = start_h +3) then
             if(vpos >= start_v and vpos < start_v+8) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
        elsif(hpos = start_h + 4) then
             if(vpos >= start_v and vpos < start_v+8) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
        elsif(hpos = start_h +5) then
             if(vpos > start_v and vpos < start_v+7) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
        elsif(hpos = start_h+6) then
             if(vpos > start_v and vpos < start_v+7) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
        elsif(hpos = start_h +7) then
             if(vpos > start_v+2 and vpos < start_v+5) then     
                 red <= "1111";
                 blue <= "1111";
                 green <="1111";
             end if;
       end if;
        
    end process;

end Behavioral;
