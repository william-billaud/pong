----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 16:46:50
-- Design Name: 
-- Module Name: buzzer - Behavioral
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

entity buzzer is
  Port ( 
    CLK : in STD_LOGIC;
    sw: in STD_LOGIC;
    speaker : out STD_LOGIC
  );
end buzzer;

architecture Behavioral of buzzer is

component ClkDivider
    Port ( CLK : in STD_LOGIC;
           Diviseur : in STD_LOGIC_VECTOR ( 19 downto 0 );
           CLK_OUT : out STD_LOGIC);
end component;

signal sol, mib, mibH, sib, re, mi, solb, delay, sOut : STD_LOGIC;
signal compteur : STD_LOGIC_VECTOR ( 15 downto 0 );
begin

ClkSol : ClkDivider port map (CLK=>CLK, Diviseur => x"3E47E", CLK_OUT=>sol);

Clkmib : ClkDivider port map (CLK=>CLK, Diviseur => x"4E400", CLK_OUT=>mib);

Clksib : ClkDivider port map (CLK=>CLK, Diviseur => x"34640", CLK_OUT=>sib);

Clkre : ClkDivider port map (CLK=>CLK, Diviseur => x"29854", CLK_OUT=>re);

Clkmi : ClkDivider port map (CLK=>CLK, Diviseur => x"24FDB", CLK_OUT=>mi);

ClkmibH : ClkDivider port map (CLK=>CLK, Diviseur => x"27403", CLK_OUT=>mibH);

Clksolb : ClkDivider port map (CLK=>CLK, Diviseur => x"41FBE", CLK_OUT=>solb);

ClkDelay : ClkDivider port map (CLK=>CLK, Diviseur => x"0C350", CLK_OUT=>delay);


process ( delay )
begin  
   if(delay'event and delay='1') then
       compteur <= compteur + 1;
       if ( compteur = x"1FE0") then
            compteur <= (others=>'0');
       end if;       
   end if;
end process;
process ( compteur, sw, sol, mib, mibH, sib, re, mi, solb, sOut ) 
begin 

    if ( sw = '0') then
if (compteur < x"01F4") then
    sOut <= sol;
elsif ( compteur >= x"01FE" and compteur < x"03F2") then
    sOut <= sol;
elsif ( compteur >= x"03FC" and compteur < x"05F0") then
    sOut <= sol;
elsif ( compteur >= x"05FA" and compteur < x"0758") then
    sOut <= mib;
elsif ( compteur >= x"0762" and compteur < x"07F8") then
    sOut <= sib;
elsif ( compteur >= x"0802" and compteur < x"09F6") then
    sOut <= sol;
elsif ( compteur >= x"0A00" and compteur < x"0B5E") then
    sOut <= mib;
elsif ( compteur >= x"0B68" and compteur < x"0BFE") then
    sOut <= sib;
elsif ( compteur >= x"0C08" and compteur < x"0DFC") then
    sOut <= sol;
elsif ( compteur >= x"0FF0" and compteur < x"11E4") then
    sOut <= re;
elsif ( compteur >= x"11EE" and compteur < x"13E2") then
    sOut <= re;
elsif ( compteur >= x"13EC" and compteur < x"15E0") then
    sOut <= re;
elsif ( compteur >= x"15EA" and compteur < x"1748") then
    sOut <= mibH;
elsif ( compteur >= x"1752" and compteur < x"17E8") then
    sOut <= sib;
elsif ( compteur >= x"17F2" and compteur < x"19E6") then
    sOut <= solb;
elsif ( compteur >= x"19F0" and compteur < x"1B4E") then
    sOut <= mib;
elsif ( compteur >= x"1B58" and compteur < x"1BEE") then
    sOut <= sib;
elsif ( compteur >= x"1BF8" and compteur < x"1DEC") then
    sOut <= sol;
else
    sOut <= '0';
end if;
else
    sOut <= '0';
end if;
end process;

speaker <= sOut;

end Behavioral;
