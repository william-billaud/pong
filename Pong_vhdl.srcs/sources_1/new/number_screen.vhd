----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 20:00:24
-- Design Name: 
-- Module Name: number_screen - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity number_screen is
    Port ( nombre : in integer range 0 to 99;
            hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
            vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
            start_h , start_v : in integer range 0 to 800:= 15;
            red : out STD_LOGIC_VECTOR (3 downto 0);
            green : out STD_LOGIC_VECTOR (3 downto 0);
            blue : out STD_LOGIC_VECTOR (3 downto 0)
    );
end number_screen;

architecture Behavioral of number_screen is
component breakNumber is
    Port ( 
        nombre : in integer range 0 to 99;
        nombreUnite, nombreDizaine : out integer range 0 to 9
    );
end component;

component digit_screen is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
        vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
        start_h , start_v : in integer range 0 to 800:= 15;
        number : in integer range 0 to 99;
        red : out STD_LOGIC_VECTOR (3 downto 0);
        green : out STD_LOGIC_VECTOR (3 downto 0);
        blue : out STD_LOGIC_VECTOR (3 downto 0));
end component;    


signal unite , dizaine: integer range 0 to 9 := 0;    
signal  r_d1 , g_d1 , b_d1: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal  r_d2 , g_d2 , b_d2: STD_LOGIC_VECTOR (3 downto 0):="0000";
signal start_h_u : integer range 0 to 800;
begin
    start_h_u<= start_h+6;
    score : breakNumber port map(
        nombre => nombre,
        nombreUnite => unite,
        nombreDizaine => dizaine);  
        
    digit1 : digit_screen port map(
        hpos => hpos,
        vpos => vpos,
        start_h => start_h,
        start_v => start_v,
        number => dizaine,
        red => r_d1,
        green => g_d1,
        blue => b_d1);      
    digit2 : digit_screen port map(
            hpos => hpos,
            vpos => vpos,
            start_h => start_h_u,
            start_v => start_v,
            number => unite,
            red => r_d2,
            green => g_d2,
            blue => b_d2);  

    red <= r_d2 or r_d1;
    blue <= b_d2 or b_d1;
    green <= g_d2 or g_d1;        


end Behavioral;
