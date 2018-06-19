----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 21:38:39
-- Design Name: 
-- Module Name: digit_screen - Behavioral
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

entity digit_screen is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           start_h , start_v : in integer range 0 to 800:= 15;
           number : in integer range 0 to 9;
           red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end digit_screen;

architecture Behavioral of digit_screen is

begin
    process(hpos , vpos)
       
        begin
          green <= "0000";
          case number is
          when 0 =>
          -- right
          if(hpos = start_h +4) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          --left
          if(hpos = start_h) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
              --botton
              if(vpos = start_v+8)then
                  green <= "1111";
              end if;
          end if;                
          when 1 =>
                -- right 
                if(hpos = start_h +4) then 
                    -- up
                    if(vpos > start_v and vpos < start_v + 4) then
                        green <= "1111";
                    end if; 
                    -- down
                    if( vpos > start_v+4 and vpos < start_v + 8) then 
                        green <= "1111";
                    end if;
                end if;
          when 2 =>
          -- right
          if(hpos = start_h +4) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;           
          end if;
          
          --left
          if(hpos = start_h) then
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
              --middle
              if(vpos = start_v+4) then
                  green <= "1111";
              end if;
              --botton
              if(vpos = start_v+8)then
                  green <= "1111";
              end if;
          end if;
          when 3 =>
          -- right
          if(hpos = start_h +4) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
                       
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
              --middle
              if(vpos = start_v+4) then
                  green <= "1111";
              end if;
              --botton
              if(vpos = start_v+8)then
                  green <= "1111";
              end if;
          end if;
          when 4 =>
          -- right
          if(hpos = start_h +4) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          --left
          if(hpos = start_h) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --middle
              if(vpos = start_v+4) then
                  green <= "1111";
              end if;
          end if;
          when 5 =>
          -- right
          if(hpos = start_h +4) then
               -- up
               if(vpos > start_v +4 and vpos < start_v + 8) then
                   green <= "1111";
               end if; 
          end if;
          
          --left
          if(hpos = start_h) then
              -- down
              if( vpos > start_v  and vpos < start_v + 4) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
              --middle
              if(vpos = start_v+4) then
                  green <= "1111";
              end if;
              --botton
              if(vpos = start_v+8)then
                  green <= "1111";
              end if;
          end if;
          when 6 =>
          -- right
          if(hpos = start_h +4) then
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          --left
          if(hpos = start_h) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
              --middle
              if(vpos = start_v+4) then
                  green <= "1111";
              end if;
              --botton
              if(vpos = start_v+8)then
                  green <= "1111";
              end if;
          end if;
          when 7 =>
          -- right
          if(hpos = start_h +4) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
          end if;
          when 8 =>
            -- right 
                 if(hpos = start_h +4) then 
                      -- up
                    if(vpos > start_v and vpos < start_v + 4) then
                        green <= "1111";
                    end if; 
                        -- down
                    if( vpos > start_v +4 and vpos < start_v + 8) then 
                        green <= "1111";
                    end if;
                 end if;
                 --left
                 if(hpos = start_h) then 
                     -- up
                     if(vpos > start_v and vpos < start_v + 4) then
                         green <= "1111";
                     end if; 
                     -- down
                     if( vpos > start_v +4 and vpos < start_v + 8) then 
                         green <= "1111";
                     end if;
                 end if;
                 
                 if(hpos > start_h and hpos < start_h +4)then
                    --top
                    if(vpos = start_v)then 
                        green <= "1111";
                    end if;
                    --middle
                    if(vpos = start_v+4) then
                        green <= "1111";
                    end if;
                    --botton
                    if(vpos = start_v+8)then
                        green <= "1111";
                    end if;
                 end if;                             
          when 9 =>
          -- right
          if(hpos = start_h +4) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
              -- down
              if( vpos > start_v +4 and vpos < start_v + 8) then
                  green <= "1111";
              end if;
          end if;
          
          --left
          if(hpos = start_h) then
              -- up
              if(vpos > start_v and vpos < start_v + 4) then
                  green <= "1111";
              end if;
          end if;
          
          if(hpos > start_h and hpos < start_h +4)then
              --top
              if(vpos = start_v)then
                  green <= "1111";
              end if;
              --middle
              if(vpos = start_v+4) then
                  green <= "1111";
              end if;
              --botton
              if(vpos = start_v+8)then
                  green <= "1111";
              end if;
          end if; 
          when others => green <="0000";
        end case;
    end process; 

end Behavioral;
   