----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 20:23:51
-- Design Name: 
-- Module Name: boutton - Behavioral
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

entity boutton is
    Port ( ps2_code_new : in STD_LOGIC;
           ps2_code : in STD_LOGIC_VECTOR (7 downto 0);
           code_on : in STD_LOGIC_VECTOR (7 downto 0);
           signal_button : out STD_LOGIC);
end boutton;

architecture Behavioral of boutton is
signal mem : std_logic := '0';
signal unset : std_logic :='0';
begin
process(ps2_code_new)
begin
if(ps2_code_new='1') then
    if(code_on = ps2_code) then 
        if(unset ='0') then
            mem<='1';
        else
            mem <='0';
            unset<='0';    
        end if;    
    elsif(x"F0"=ps2_code) then
        unset<='1';
    else
        unset<='0';    
    end if;    
end if;

end process;

signal_button <=mem;
end Behavioral;
