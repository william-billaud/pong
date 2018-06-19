----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 15:45:32
-- Design Name: 
-- Module Name: clk_min - Behavioral
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

entity clk_min is
    Port ( clk : in STD_LOGIC;
           clk_m : out STD_LOGIC);
end clk_min;

architecture Behavioral of clk_min is

signal compteur_m : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
signal clk_min_int : STD_LOGIC := '0';

begin


process(clk)
begin
if(clk'event and clk = '1') then
    compteur_m <= compteur_m + 1;
    if(compteur_m =  X"B2D05E00") then
        if(clk_min_int = '1') then
            clk_min_int <= '0';
        else
            clk_min_int <= '1';
        end if;
        compteur_m <= X"00000000";
    end if;
end if;
clk_m <= clk_min_int;
end process;

end Behavioral;
