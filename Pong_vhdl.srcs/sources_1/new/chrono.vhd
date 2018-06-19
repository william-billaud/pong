----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 14:12:53
-- Design Name: 
-- Module Name: chrono - Behavioral
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

entity chrono is
    Port ( clk : in STD_LOGIC; 
           sec : out integer range 0 to 9;
           dsec : out integer range 0 to 5;
           min : out integer range 0 to 9;
           dmin : out integer range 0 to 5;
           in_progress : out STD_LOGIC);
end chrono;

architecture Behavioral of chrono is

signal compteur_s : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
signal compteur_m : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
signal sec_int : integer range 0 to 9 := 0;
signal dsec_int : integer range 0 to 6 := 0;
signal min_int : integer range 0 to 9 := 3;
signal dmin_int : integer range 0 to 6 := 0;
signal in_progress_int : STD_LOGIC := '1';
signal clk_s_int, clk_min_int : STD_LOGIC;

component clk_sec
    Port ( clk : in STD_LOGIC;
           clk_s : out STD_LOGIC);
end component;

component clk_min
    Port ( clk : in STD_LOGIC;
           clk_m : out STD_LOGIC);
end component;

begin

compteur_sec : clk_sec port map ( clk => clk, clk_s => clk_s_int );
compteur_min : clk_min port map ( clk => clk, clk_m => clk_min_int);


process(clk)
begin
if(clk_s_int'event and clk_s_int = '1' and sec_int /= 0 and dsec_int /= 0) then
    sec_int <= sec_int - 1;
elsif(clk_s_int'event and clk_s_int = '1' and sec_int = 0 and dsec_int /= 0) then
    sec_int <= 9;
    dsec_int <= dsec_int - 1;
elsif( dsec_int = 0 and sec_int = 0) then
    sec_int <= 9;
    dsec_int <= 5; 
end if;
sec <= sec_int;
dsec <= dsec_int;
end process;

process(clk)
begin
in_progress_int <= '1';
if(clk_min_int'event and clk_min_int = '1' and min_int /= 0 and min_int /= 0) then
    min_int <= min_int - 1;
elsif(clk_min_int'event and clk_min_int = '1' and min_int = 0 and dmin_int /= 0) then
    min_int <= 9;
    dmin_int <= dmin_int - 1;
elsif( dmin_int = 0 and min_int /= 0) then
    min_int <= min_int - 1;
elsif( dmin_int = 0 and min_int = 0 and dsec_int = 0 and sec_int = 0) then
    in_progress_int <= '0';
end if;
in_progress <= in_progress_int;
dmin <= dmin_int;
min <= min_int;
end process;


end Behavioral;
