----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 14:13:41
-- Design Name: 
-- Module Name: move_ball - Behavioral
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

entity move_ball is
  Port (
    vga_clk : in STD_LOGIC;
    new_frame : in STD_LOGIC;
    reset : in STD_LOGIC;
    paddle_h1 : in integer range 0 to 800;
    paddle_v1 : in integer range 0 to 800;
    paddle_h2 : in integer range 0 to 800;
    paddle_v2 : in integer range 0 to 800;
    p1_up : in STD_LOGIC ;
    p1_down : in STD_LOGIC;
    p2_up : in  STD_LOGIC ;
    p2_down : in STD_LOGIC;
    hBalle : out integer range 0 to 800;
    vBalle : out integer range 0 to 800;
    scoreJ1_out	: out integer range 0 to 99;
    scoreJ2_out : out integer range 0 to 99
   );
end move_ball;

architecture Behavioral of move_ball is
    signal ball_up : std_logic:= '0';
    signal ball_right : std_logic:= '1';
    signal ball_pos_h1 : integer range 0 to 800:= 318;
    signal ball_pos_v1 : integer range 0 to 800:= 238;
    signal ball_speed_h	: integer range 0 to 5:= 2;
    signal ball_speed_v	: integer range 0 to 5:= 2;
    signal scoreJ1	: integer range 0 to 99:= 0;
    signal scoreJ2	: integer range 0 to 99:= 0;

begin
process (vga_clk, p1_up,p1_down,p2_down,p2_up,new_frame) 
begin

   if (rising_edge(vga_clk) and new_frame = '1') then
      if (reset = '1') then
          ball_pos_v1 <= 218;
          ball_pos_h1 <= 318;
          ball_speed_v <=2;
          scoreJ1 <= 0;
          scoreJ2 <= 0;
      else
          --up and down 
           if (ball_pos_v1 < 469 and ball_up = '1') then
               ball_pos_v1 <= ball_pos_v1 + ball_speed_v;
           elsif (ball_up = '1') then
               ball_up <= '0';
           elsif (ball_pos_v1 > 3 and ball_up = '0') then
               ball_pos_v1 <= ball_pos_v1 - ball_speed_v;
           elsif (ball_up = '0') then
               ball_up <= '1';
           end if;
           
           --left and right
           if (ball_pos_h1 < 628 and ball_right = '1') then
               ball_pos_h1 <= ball_pos_h1 + ball_speed_h;
           elsif (ball_right = '1') then
               scoreJ2 <= scoreJ2 + 1; 
               ball_right    <= '0';
               ball_pos_v1 <= 238;
               ball_pos_h1 <= 318;      
               ball_speed_v <= 2;
               ball_speed_h <= 2;           
           elsif (ball_pos_h1 > 4 and ball_right = '0') then
               ball_pos_h1 <= ball_pos_h1 - ball_speed_h;
           elsif (ball_right = '0') then
               scoreJ1 <= scoreJ1+1; 
               ball_right <= '1';
               ball_pos_v1 <= 238;
               ball_pos_h1 <= 318;
               ball_speed_v <= 2;
               ball_speed_h <= 2;            
           end if;
         
            -- rebond paddle 1
           if(ball_pos_h1 <= (paddle_h1 + 5) and (ball_pos_h1+8) > paddle_h1 and ball_pos_v1 >= paddle_v1 and ball_pos_v1 < (paddle_v1+40) )  then                
               if((p1_up = '1' and ball_up = '1') or (p1_down ='1' and ball_up ='0' )) then                                  
                   if(ball_speed_v < 4) then
                        ball_speed_v <= ball_speed_v + 1;
                        ball_speed_h <= ball_speed_h + 1;
                    end if;
               elsif((p1_up = '1' and ball_up = '0') or (p1_down ='1' and ball_up ='1'))then
                   if(ball_speed_v > 1)then
                        ball_speed_v <= ball_speed_v - 1;                        
                    end if;
                    if(ball_speed_h > 2) then
                        ball_speed_h <= ball_speed_h - 1;
                    end if;
               end if;
               ball_right <= '0'; 
           end if;
           
           -- rebond paddle 2
           if((ball_pos_h1 + 8) >= paddle_h2 and ball_pos_h1 < (paddle_h2+5) and ball_pos_v1 >= (paddle_v2) and ball_pos_v1 < (paddle_v2+40)) then    
                if((p2_up = '1' and ball_up = '1') or (p2_down ='1' and ball_up ='0' )) then
                     if(ball_speed_v < 4) then 
                         ball_speed_v <= ball_speed_v + 1;
                         ball_speed_h <= ball_speed_h + 1;
                     end if;
                elsif((p2_up = '1' and ball_up = '0') or (p2_down ='1' and ball_up ='1'))then
                     if(ball_speed_v > 1)then
                          ball_speed_v <= ball_speed_v - 1;
                     end if;
                     if(ball_speed_h > 2) then
                        ball_speed_h <= ball_speed_h - 1;
                     end if;
                end if;
                ball_right <= '1';
           end if;            
       end if;
   end if; 
end process;

hBalle<=ball_pos_h1;
vBalle<=ball_pos_v1;
scoreJ1_out <= scoreJ1;
scoreJ2_out <= scoreJ2;

end Behavioral;
