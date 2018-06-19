----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.06.2018 23:08:26
-- Design Name: 
-- Module Name: ClkDivider - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClkDivider is
    Port ( CLK : in STD_LOGIC;
           Diviseur : in STD_LOGIC_VECTOR ( 19 downto 0 );
           CLK_OUT : out STD_LOGIC);
end ClkDivider;

architecture Behavioral of ClkDivider is
    signal NEW_CLK : STD_LOGIC := '1'; -- Toggle
begin

    process ( CLK, NEW_CLK )    
        variable compteur : unsigned ( 19 downto 0 ) := x"00000"; -- variable needed for counter        
    begin    
        if(CLK'event and CLK='1') then
            compteur := compteur + 1; -- counting
            if ( STD_LOGIC_VECTOR ( compteur ) = Diviseur ) then -- when the counter reaches the value of the divisor
                NEW_CLK <= NOT NEW_CLK; -- toggling signal toogles its value
                compteur := x"00000"; -- counter resets to 0                
            end if;            
        end if;        
    end process;    
    CLK_OUT <= NEW_CLK; -- desired clock is the same as the toogling signal
end Behavioral;
