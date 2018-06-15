----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2018 09:51:27
-- Design Name: 
-- Module Name: clk_1Mhz - Behavioral
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

entity clock_vga is
 Port ( clk_in : in STD_LOGIC;
          reset : in STD_LOGIC;
          clk_out : out STD_LOGIC);
end clock_vga;

architecture Behavioral of clock_vga is
signal clk_int : STD_LOGIC_VECTOR (2 downto 0) := (others =>'0');
signal etat : STD_Logic := '0';

begin
    process(clk_in, reset)
    begin 
        if(reset = '1')then 
            clk_int <= (others =>'0');
        elsif(clk_in'event and clk_in = '1') then 
            clk_int <= clk_int + 1;            
        end if;
    
        if(clk_int = "100") then
            if(etat ='0') then                
                etat <= '1';
            else                
                etat <='0';
            end if; 
            clk_int <= (others =>'0');
         end if;
         
    end process;
   
    clk_out <= etat;

end Behavioral;
