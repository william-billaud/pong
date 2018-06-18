----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 15:13:00
-- Design Name: 
-- Module Name: driver7Segments - Behavioral
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

entity driver7Segments is
    Port ( CLK : in STD_LOGIC;
           digit1 : in STD_LOGIC_VECTOR (6 downto 0);
           digit2 : in STD_LOGIC_VECTOR (6 downto 0);
           digit3 : in STD_LOGIC_VECTOR (6 downto 0);
           digit4 : in STD_LOGIC_VECTOR (6 downto 0);
           digit_OUT : out STD_LOGIC_VECTOR (6 downto 0);
           digit_choice : out STD_LOGIC_VECTOR (3 downto 0));
end driver7Segments;

architecture Behavioral of driver7Segments is

begin
    process (CLK)
        variable SEL : unsigned (1 downto 0) := "00"; -- Entree   
    begin    
        if (CLK'event and CLK='1') then
            case SEL is            
                when "00" => digit_choice <= "0111";
                    digit_OUT <= digit1;
                    SEL := SEL + 1;                 
                when "01" => digit_choice <= "1011";
                    digit_OUT <= digit2;
                    SEL := SEL + 1;                       
                when "10" => digit_choice <= "1101";
                    digit_OUT <= digit3;
                    SEL := SEL + 1;                 
                when others => digit_choice <= "1110";
                    digit_OUT <= digit4;
                    SEL := "00";
            end case;            
        end if;        
    end process;
end Behavioral;