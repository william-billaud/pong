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
           balle_v : in integer range 0 to 800;
           scoreJ1 : in integer range 0 to 99;
           scoreJ2 : in integer range 0 to 99);
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

component draw_balle is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           start_h , start_v : in integer range 0 to 800:= 15;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component breakNumber is
    Port ( 
        nombre : in integer range 0 to 99;
        nombreUnite, nombreDizaine : out integer range 0 to 9
    );
end component;

signal  r_d1 , g_d1 , b_d1: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d2 , g_d2 , b_d2: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d3 , g_d3 , b_d3: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d4 , g_d4 , b_d4: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_b , g_b , b_b: STD_LOGIC_VECTOR (3 downto 0):="0000";

signal  r_out , g_out , b_out: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal uniteJ1 , dizaineJ1, uniteJ2, dizaineJ2 : integer range 0 to 9 := 0;
begin

score1 : breakNumber port map(
    nombre => scoreJ1,
    nombreUnite => uniteJ1,
    nombreDizaine => dizaineJ1);     
score2 : breakNumber port map(
    nombre => scoreJ2,
    nombreUnite => uniteJ2,
    nombreDizaine => dizaineJ2);  
    
digit1 : digit_screen port map(
    hpos => hpos,
    vpos => vpos,
    start_h => 15,
    start_v => 15,
    number => dizaineJ1,
    red => r_d1,
    green => g_d1,
    blue => b_d1);      
digit2 : digit_screen port map(
        hpos => hpos,
        vpos => vpos,
        start_h => 21,
        start_v => 15,
        number => uniteJ1,
        red => r_d2,
        green => g_d2,
        blue => b_d2);  
digit3 : digit_screen port map(
        hpos => hpos,
        vpos => vpos,
        start_h => 33,
        start_v => 15,
        number => dizaineJ2,
        red => r_d3,
        green => g_d3,
        blue => b_d3);  
digit4 : digit_screen port map(
        hpos => hpos,
        vpos => vpos,
        start_h => 39,
        start_v => 15,
        number => uniteJ2,
        red => r_d4,
        green => g_d4,
        blue => b_d4);      
        
balle : draw_balle port map(
            hpos => hpos,
            vpos => vpos,
            start_h => balle_h,
            start_v => balle_v,
            red => r_b,
            green => g_b,
            blue => b_b); 
            
     process(hpos, vpos,blank,r_b,paddle_h1,paddle_v1,paddle_v2,paddle_h2,b_b,g_b,g_d1,g_d2,g_d3,g_d4)
     begin
        r_out <="0000";
        g_out <= "0000";
        b_out<="0000";
         if( blank = '0')then
             if(r_b /="0000") then
                r_out <= r_b;
             elsif((hpos >= paddle_h1 and hpos < paddle_h1 + 5) and (vpos >= paddle_v1 and vpos < paddle_v1 + 40))then
                r_out <= "1111";
             elsif((hpos >= paddle_h2 and hpos < paddle_h2 + 5) and (vpos >= paddle_v2 and vpos < paddle_v2 + 40))then
                r_out <= "1111";
             elsif (hpos <3 or vpos >476 or hpos > 636 or vpos < 3) then
                r_out <="1111";
             end if;
                     
             if(b_b /="0000") then
                b_out <= b_b;
             elsif((hpos >= paddle_h2 and hpos < paddle_h2 + 5) and (vpos >= paddle_v2 and vpos < paddle_v2 + 40))then
                b_out <= "1111";
             elsif(hpos <3 or vpos >476 or hpos > 636 or vpos < 3) then
                b_out <="1111";
             end if;
             
             if(g_b /="0000") then
                g_out <= g_b;
             elsif((hpos >= paddle_h1 and hpos < paddle_h1 + 5) and (vpos >= paddle_v1 and vpos < paddle_v1 + 40))then
                g_out <= "1111";
             elsif(g_d1 /="0000") then
                g_out <= g_d1;
             elsif(g_d2 /="0000") then
                g_out <= g_d2;
             elsif(g_d3 /="0000") then
                g_out <= g_d3;
             elsif(g_d4 /="0000") then
                g_out <= g_d4;
             elsif (hpos <3 or vpos >476 or hpos > 636 or vpos < 3) then
                g_out <="1111";
             end if;
         end if;
     end process;

    rouge <=r_out;
    bleu <= b_out;
    vert <= g_out;         

end Behavioral;
