----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 15:06:40
-- Design Name: 
-- Module Name: CLK_DIGIT - Behavioral
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

entity CLK_DIGIT is
    Port ( CLK_100MHZ : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC);
end CLK_DIGIT;

architecture Behavioral of CLK_DIGIT is
signal compteur : STD_LOGIC_VECTOR( 31 downto 0 );
signal NEW_CLK : STD_LOGIC := '0'; -- Toggle
begin
process ( CLK_100MHZ )   
    begin    
        if(CLK_100MHZ'event and CLK_100MHZ='1') then
            compteur <= compteur + 1; -- counting
            if ( compteur = x"000186A0" ) then -- when the counter reaches the value of the divisor
                NEW_CLK <= NOT NEW_CLK; -- toggling signal toogles its value
                compteur <= (others => '0'); -- counter resets to 0                
            end if;            
        end if;        
    end process;    
    CLK_OUT <= NEW_CLK; -- desired clock is the same as the toogling signal
end Behavioral;
