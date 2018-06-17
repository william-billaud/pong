----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2018 15:14:48
-- Design Name: 
-- Module Name: clk_25MHz - Behavioral
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

entity clk_25MHz is
    Port ( clk_100MHz : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk_25MHz;

architecture Behavioral of clk_25MHz is
signal cpt_int : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
signal output : STD_LOGIC :='1';
begin
process(clk_100MHz)
begin
if(clk_100MHz'event and clk_100MHz='1') then
    cpt_int <= cpt_int +1 ;
if(cpt_int= X"3") then
    cpt_int<="00";
    if(output = '0') then
        output<= '1';
    else
        output <='0';
    end if;        
end if;
end if;
end process;
clk_out <= output;
end Behavioral;
