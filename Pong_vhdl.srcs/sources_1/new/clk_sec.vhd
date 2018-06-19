----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 15:36:44
-- Design Name: 
-- Module Name: clk_sec - Behavioral
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

entity clk_sec is
    Port ( clk : in STD_LOGIC;
           clk_s : out STD_LOGIC);
end clk_sec;

architecture Behavioral of clk_sec is

signal clk_s_int : STD_LOGIC := '0';
signal compteur_s : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
begin

process(clk)
begin
if(clk'event and clk = '1') then
    compteur_s <= compteur_s +1;
    if(compteur_s =  X"02FAF080") then
        if(clk_s_int = '1') then
            clk_s_int <= '0';
        else
            clk_s_int <= '1';
        end if;
        compteur_s <= X"00000000";
    end if;
end if;
clk_s <= clk_s_int;
end process;



end Behavioral;
