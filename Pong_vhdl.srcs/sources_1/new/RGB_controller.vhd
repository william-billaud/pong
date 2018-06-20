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
           scoreJ2 : in integer range 0 to 99;
           sec : in integer range 0 to 59;
           min : in integer range 0 to 3);
end RGB_controller;

architecture Behavioral of RGB_controller is

component number_screen is
    Port ( nombre : in integer range 0 to 99;
            hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
            vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
            start_h , start_v : in integer range 0 to 800:= 15;
            red : out STD_LOGIC_VECTOR (3 downto 0);
            green : out STD_LOGIC_VECTOR (3 downto 0);
            blue : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;    

component draw_balle is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           start_h , start_v : in integer range 0 to 800:= 15;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component draw_paddle is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           blank : in STD_LOGIC;
           paddle_h : in integer range 0 to 800;
           paddle_v : in integer range 0 to 800;
           rouge : out STD_LOGIC_VECTOR (3 downto 0);
           bleu : out STD_LOGIC_VECTOR (3 downto 0);
           vert : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component draw_dotline
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           blank : in STD_LOGIC;
           blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end component;

component draw_border
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           blank : in STD_LOGIC;
           blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end component;

component draw_winner is
  Port (hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
         vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
         start_h , start_v : in integer range 0 to 800:= 15;
         red : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
         green : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
         blue : out STD_LOGIC_VECTOR (3 downto 0):= "0000");
end component;

signal  r_d1 , g_d1 , b_d1: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d2 , g_d2 , b_d2: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d3 , g_d3 , b_d3: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d4 , g_d4 , b_d4: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_b , g_b , b_b: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_dotline , g_dotline , b_dotline: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_border , g_border , b_border: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_w_1 , g_w_1 , b_w_1: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_w_2 , g_w_2 , b_w_2: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_w , g_w , b_w: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_pad_1 , g_pad_1 , b_pad_1: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_pad_2 , g_pad_2 , b_pad_2: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal score : std_logic_vector (1 downto 0);
begin
    
scoreJoueur2 : number_screen port map(
    nombre => scoreJ2,
    hpos => hpos,
    vpos => vpos,
    start_h => 303,
    start_v => 15,
    red => r_d1,
    green => g_d1,
    blue => b_d1);
     
scoreJoueur1 : number_screen port map(
    nombre => scoreJ1,
    hpos => hpos,
    vpos => vpos,
    start_h => 324,
    start_v => 15,
    red => r_d2,
    green => g_d2,
    blue => b_d2);
    
minutes : number_screen port map(
        nombre => min,
        hpos => hpos,
        vpos => vpos,
        start_h => 305,
        start_v => 460,
        red => r_d3,
        green => g_d3,
        blue => b_d3);
secondes : number_screen port map(
                nombre => sec,
                hpos => hpos,
                vpos => vpos,
                start_h => 323,
                start_v => 460,
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
coupeJ1 : draw_winner port map(
        hpos => vpos,
        vpos => hpos,
        start_h => 15,
        start_v => 15,
        red => r_w_1,
        green => g_w_1,
        blue => b_w_1);

coupeJ2 : draw_winner port map(
        hpos => vpos,
        vpos => hpos,
        start_h => 15,
        start_v => 600,
        red => r_w_2,
        green => g_w_2,
        blue => b_w_2);         
dotline : draw_dotline port map (
              hpos => hpos,
              vpos => vpos,
              blank => blank,
              red => r_dotline,
              green => g_dotline,
              blue => b_dotline);     
border : draw_border port map (
              hpos => hpos,
              vpos => vpos,
              blank => blank,
              red => r_border,
              green => g_border,
              blue => b_border); 
pad_1 : draw_paddle port map(
        hpos => hpos,
        vpos => vpos,
        blank => blank,
        paddle_h => paddle_h1,
        paddle_v => paddle_v1,
        rouge => r_pad_1,
        vert => g_pad_1,
        bleu => b_pad_1
        );

pad_2 : draw_paddle port map(
        hpos => hpos,
        vpos => vpos,
        blank => blank,
        paddle_h => paddle_h2,
        paddle_v => paddle_v2,
        rouge => r_pad_2,
        vert => g_pad_2,
        bleu => b_pad_2
        );        


score(0)<= '1' when scoreJ1>scoreJ2 else '0';
score(1)<= '1' when scoreJ2>scoreJ1 else '0';
With score SELECT r_w <= r_w_1 when "10",
                         r_w_2 when "01",
                        (r_w_2 or r_w_1) when others;         
With score SELECT b_w <= b_w_1 when "10",
                         b_w_2 when "01",
                         (b_w_2 or b_w_1) when others;                          
With score SELECT g_w <= g_w_1 when "10",
                  g_w_2 when "01",
                  (g_w_2 or g_w_1) when others;                               
    rouge <= r_b or r_pad_1 or r_pad_2 or r_dotline or r_border or r_w;
    bleu <= b_b or b_pad_2 or b_dotline or b_border or b_w ;
    vert <= g_d1 or g_d2 or g_d3 or g_d4 or g_b or g_pad_1 or g_border or g_dotline or g_w;         

end Behavioral;
