----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2018 15:29:14
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( clk : in STD_LOGIC;
       pause : in STD_LOGIC;
       reset : in STD_LOGIC;
       Vsync : out std_logic;
       Hsync : out std_logic;
       vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
       vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
       vgaGreen : out STD_LOGIC_VECTOR (3 downto 0));
end top_level;

architecture Behavioral of top_level is
    component clk_25MHz is
        Port ( 
        clk_100MHz : in STD_LOGIC;
        clk_out : out STD_LOGIC);
    end component;

    component vga_controller is
        port(
           rst         : in std_logic;
           pixel_clk   : in std_logic;
           HS          : out std_logic;
           VS          : out std_logic;
           hcount      : out std_logic_vector(10 downto 0);
           vcount      : out std_logic_vector(10 downto 0);
           blank       : out std_logic
        );
    end component;
signal clock_vga_int :  std_logic;       
signal color,blanc : std_logic := '1';
signal countH,countV : std_logic_vector(10 downto 0);
begin
    clk_vga : clk_25MHZ port map(clk_100MHz=>clk,clk_out => clock_vga_int);
    vga : vga_controller port map(rst => reset,pixel_clk=>clock_vga_int,
    HS =>Hsync, VS=> Vsync,
    hcount=>countH,Vcount=>countV,blank=> blanc);
    vgaRed <= "0000";
    vgaBlue <= "0000";
    vgaGreen <= "1111";
end Behavioral;
