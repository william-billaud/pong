----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 22:52:22
-- Design Name: 
-- Module Name: draw_winner - Behavioral
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

entity draw_winner is
  Port (hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
         vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
         start_h , start_v : in integer range 0 to 800:= 15;
         red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
         green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
         blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end draw_winner;

architecture Behavioral of draw_winner is
begin
   process(hpos , vpos,start_h,start_v)      
     begin
     red <="0000";
     green <="0000";
     blue <="0000";
     if(hpos = start_h) then
         if(vpos >= start_v +3 and vpos <= start_v+13) then
             red<="1100";
             green<="0100";
             blue<="0001";
         end if;
     elsif(hpos = start_h + 1) then
             if(vpos >= start_v +4 and vpos <= start_v+12) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v+3 or vpos = start_v+13) then
                 red<="1111";
                 green<="1101";
             end if;     
     elsif(hpos = start_h + 2 ) then
              if(vpos >= start_v +4 and vpos <= start_v+12) then
                 red<="1111";
                 green<="1101";    
             end if;
             if((vpos >= start_v and vpos <= start_v + 3) or (vpos >= start_v +13 and vpos < start_v +16)) then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;        
     elsif(hpos = start_h + 3) then
             if((vpos >= start_v +4 and vpos <= start_v+12) or vpos = start_v+1  or vpos = start_v+2 or vpos = start_v+14 or vpos = start_v+15) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v  or vpos = start_v+3 or vpos = start_v+13 or vpos = start_v+16) then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 4) then
             if((vpos >= start_v +4 and vpos <= start_v+12) or vpos = start_v+1  or vpos = start_v+2 or vpos = start_v+14 or vpos = start_v+15) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v  or vpos = start_v+3 or vpos = start_v+13 or vpos = start_v+16) then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 5) then
             if((vpos >= start_v +4 and vpos <= start_v+12) or vpos = start_v+2 or vpos = start_v+14) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v  or vpos = start_v+3 or vpos = start_v+13 or vpos = start_v+16 or vpos = start_v +15 or vpos = start_v + 1 ) then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;       
     elsif(hpos = start_h + 6) then
             if(vpos >= start_v +4 and vpos <= start_v+12) then
                 red<="1111";
                 green<="1101";    
             end if;
             if((vpos >=start_v +1 and vpos <= start_v+3) or (vpos >=start_v +13 and vpos <= start_v+15))then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 7) then
             if(vpos >= start_v +4 and vpos <= start_v+12) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v+3 or vpos = start_v + 13)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 8) then
             if(vpos >= start_v +5 and vpos <= start_v+11) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v+3 or vpos = start_v + 13 or vpos= start_v+ 4 or vpos = start_v +12)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 9) then
             if(vpos >= start_v +6 and vpos <= start_v+10) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v+5 or vpos = start_v + 11 or vpos= start_v+ 4 or vpos = start_v +12)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 10) then
             if(vpos >= start_v +7 and vpos <= start_v+9) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v+5 or vpos = start_v + 11 or vpos= start_v+ 6 or vpos = start_v +10)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 11) then
             if( vpos = start_v + 8) then
                 red<="1111";
                 green<="1101";
             end if;
             if(vpos = start_v +7 or vpos = start_v +9)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 12) then
             if( vpos = start_v + 8) then
                 red<="1111";
                 green<="1101";
             end if;
             if(vpos = start_v +7 or vpos = start_v +9)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 13) then
             if( vpos = start_v + 8) then
                 red<="1111";
                 green<="1101";
             end if;
             if(vpos = start_v +7 or vpos = start_v +9)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 14) then
             if( vpos = start_v + 8) then
                 red<="1111";
                 green<="1101";
             end if;
             if(vpos = start_v +7 or vpos = start_v +9)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 15) then
             if( vpos = start_v + 8) then
                 red<="1111";
                 green<="1101";
             end if;
             if(vpos = start_v +7 or vpos = start_v +9 or vpos = start_v +6 or vpos = start_v + 10 )then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if;
     elsif(hpos = start_h + 16) then
         if(vpos >= start_v +6 and vpos <= start_v+11) then
                 red<="1111";
                 green<="1101";    
             end if;
             if(vpos = start_v+5 or vpos = start_v + 12)then
                 red<="1100";
                 green<="0100";
                 blue<="0001";
             end if; 
     elsif(hpos = start_h + 17) then
         if(vpos >= start_v +5 and vpos <= start_v+12) then
             red<="1100";
             green<="0100";
             blue<="0001";
         end if;
     end if;
     if(hpos >= start_h+ 3 and  hpos <=start_h+7 and vpos = start_v +8) then
         red<="0000";
         green<="0000";
         blue<="0000";
      end if;
      if((hpos =start_h +4 and vpos = start_v+ 7) or (hpos  = start_h+7 and vpos =start_v+7) or(hpos =start_h+7 and vpos=start_v+9)) then
            red<="0000";
            green<="0000";
            blue<="0000";
       end if;
      if(hpos >= start_h + 2 and  hpos <= start_h +6 and vpos = start_v +5) then
             red<="1111";
             green<="1111";
             blue<="1111";
      end if;      

 end process;



end Behavioral;
