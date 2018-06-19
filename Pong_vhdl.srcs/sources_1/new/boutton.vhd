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
signal breakcode : std_logic := '0';
begin
process(ps2_code_new,ps2_code)
begin
if(ps2_code_new='1' and ps2_code_new'event) then
    if(breakcode='0') then    
        if(code_on=ps2_code) then
            mem<='1';
        elsif(ps2_code="11110000") then
            breakcode<='1';    
        end if; 
     elsif(breakcode='1') then
        breakcode<='0';
        if(ps2_code=code_on) then
            mem<='0';
         end if;          
    end if;        
end if;    
end process;
signal_button <=mem;
end Behavioral;
