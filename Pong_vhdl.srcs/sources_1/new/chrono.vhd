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
           reset : in std_logic;         
           sec : out integer range 0 to 59;
           min : out integer range 0 to 3;
           in_progress : out STD_LOGIC);
end chrono;

architecture Behavioral of chrono is

signal compteur_s : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
signal compteur_m : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
signal sec_int : integer range 0 to 59 := 59;
signal min_int : integer range 0 to 9 := 2;
signal in_progress_int : STD_LOGIC := '1';
signal clk_s_int, clk_min_int : STD_LOGIC;
signal clk_p : std_logic;

component clk_sec
    Port ( clk : in STD_LOGIC;
            reset : in STD_LOGIC; 
           clk_s : out STD_LOGIC);
end component;

component clk_min
    Port ( clk : in STD_LOGIC;
            reset : in STD_LOGIC; 
           clk_m : out STD_LOGIC);
end component;

begin

compteur_sec : clk_sec port map ( clk => clk_p,reset => reset, clk_s => clk_s_int );
compteur_min : clk_min port map ( clk => clk_p,reset => reset, clk_m => clk_min_int);


process(clk_s_int,reset)
    begin
    if(reset='1') then
        sec_int <=59;
    elsif(clk_s_int'event and clk_s_int = '1') then

        if(sec_int=0) then
           sec_int<=59;
         else  
            sec_int <= sec_int - 1;
         end if;   
    end if;
end process;

process(clk_min_int,reset)
    begin
    if(reset='1') then
            min_int <=2;
     elsif(clk_min_int'event and clk_min_int = '1') then
        min_int <= min_int - 1;
    end if;
end process;

process(min_int,sec_int,reset)
begin
    if(reset='1') then
        in_progress_int <= '1';
     elsif(min_int = 0 and sec_int =0) then
        in_progress_int <='0';
     else
        in_progress_int <='1';   
    end if;    
end process;

process(clk,in_progress_int)
        begin
            if(in_progress_int ='0') then
                clk_p <='0';
            else
                clk_p<=clk;        
            end if;
end process;

sec <= sec_int;
in_progress <= in_progress_int;
min <= min_int;
end Behavioral;
