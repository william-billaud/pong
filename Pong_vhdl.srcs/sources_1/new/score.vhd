----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 14:46:06
-- Design Name: 
-- Module Name: score - Behavioral
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

entity score is
    Port ( scoreJ1 : in integer range 0 to 99;
           scoreJ2 : in integer range 0 to 99;
           digit_OUT : out STD_LOGIC_VECTOR (6 downto 0);
           digit_choice : out STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC);
end score;

architecture Behavioral of score is

component breakNumber
    Port ( 
        nombre : in integer range 0 to 99;
        nombreUnite, nombreDizaine : out integer range 0 to 9
    );
end component;

component digit
    Port ( number : in integer range 0 to 9;
           LedOut : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component CLK_DIGIT
    Port ( CLK_100MHZ : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC);
end component;

component driver7Segments
    Port ( CLK : in STD_LOGIC;
           digit1 : in STD_LOGIC_VECTOR (6 downto 0);
           digit2 : in STD_LOGIC_VECTOR (6 downto 0);
           digit3 : in STD_LOGIC_VECTOR (6 downto 0);
           digit4 : in STD_LOGIC_VECTOR (6 downto 0);
           digit_OUT : out STD_LOGIC_VECTOR (6 downto 0);
           digit_choice : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal uniteJ1, uniteJ2, dizaineJ1, dizaineJ2 : integer range 0 to 9;
signal digit1, digit2, digit3, digit4 : STD_LOGIC_VECTOR (6 downto 0);
signal CLKDigit : STD_LOGIC;

begin
nombreJ1 : breakNumber port map ( nombre => scoreJ1, nombreUnite => uniteJ1, nombreDizaine => dizaineJ1);
DigitDizaineJ1 : digit port map ( number => dizaineJ1, LedOut =>  digit1);
DigitUniteJ1 : digit port map ( number => uniteJ1, LedOut =>  digit2);

nombreJ2 : breakNumber port map ( nombre => scoreJ2, nombreUnite => uniteJ2, nombreDizaine => dizaineJ2);
DigitDizaineJ2 : digit port map ( number => dizaineJ2, LedOut =>  digit3);
DigitUniteJ2 : digit port map ( number => uniteJ2, LedOut =>  digit4);

Clk7Seg : CLK_DIGIT port map ( CLK_100MHZ=> clk, CLK_OUT => CLKDigit);

Driver : driver7Segments port map ( CLK => CLKDigit, digit1 => digit1, digit2=>digit2, digit3=>digit3, digit4 => digit4, digit_OUT=>digit_OUT , digit_choice =>digit_choice); 
end Behavioral;
