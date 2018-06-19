----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 11:47:21
-- Design Name: 
-- Module Name: paddle_driver - Behavioral
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

entity paddle_driver is
    Port ( vga_clk : in STD_LOGIC;
            paddle_speed : in integer range 0 to 15:= 4;
            new_frame : in std_logic;
            p_up : in STD_LOGIC;
            p_down : in STD_LOGIC;
            pos_paddle : out integer range 0 to 800;
            reset : in STD_LOGIC);
end paddle_driver;

architecture Behavioral of paddle_driver is
signal mem_pos_paddle : integer range 0 to 800 := 220;
begin
 process (vga_clk) 
begin
   if (reset = '1') then
        mem_pos_paddle <= 220;
   end if;
   if (rising_edge(vga_clk) and new_frame = '1') then
       
       if (p_up = '1') then  
           if (mem_pos_paddle < 440) then
                mem_pos_paddle <= mem_pos_paddle + paddle_speed;
           end if;
       elsif ( p_down = '1') then  
           if (mem_pos_paddle > 3) then
            mem_pos_paddle <= mem_pos_paddle - paddle_speed;
           end if;
       end if;           
   end if;
        
end process;

pos_paddle <= mem_pos_paddle;
end Behavioral;
