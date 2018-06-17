----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2018 16:35:34
-- Design Name: 
-- Module Name: tb_clk_25MHz - Behavioral
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

entity tb_clk_25MHz is
--  Port ( );
end tb_clk_25MHz;

architecture Behavioral of tb_clk_25MHz is
component clk_25MHz is
    Port ( clk_100MHz : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

signal clk_100MHz,clk_out : std_logic := '0';
begin
uut :clk_25MHz
port map(clk_100Mhz=>clk_100MHz,clk_out=>clk_out);
process
    begin
    clk_100MHz <='0';
    wait for 10ns;
    clk_100MHz<='1';
    wait for 10ns;
    end process;
    

end Behavioral;
