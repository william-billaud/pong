library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pong is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           p1_up : in STD_LOGIC;
           p1_down : in STD_LOGIC;
           p2_up : in STD_LOGIC;
           p2_down : in STD_LOGIC;
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC);
end pong;

architecture Behavioral of pong is

component vga_controller_640_60 is
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

component clock_vga is
port ( clk_in : in STD_LOGIC;
       reset : in STD_LOGIC;
       clk_out : out STD_LOGIC);
end component;

signal vga_clk : std_logic:='0'; 
signal rst : std_logic:='0'; 
signal set_red, set_green, set_blue : std_logic_vector(3 downto 0):= (others => '0');
signal hpos : std_logic_vector(10 downto 0);
signal vpos : std_logic_vector(10 downto 0);
signal blank : std_logic:='0';

signal paddle_h1 : integer range 0 to 800:= 100;
signal paddle_v1 : integer range 0 to 800:= 10;
signal paddle_h2 : integer range 0 to 800:= 100;
signal paddle_v2 : integer range 0 to 800:= 615;

signal ball_pos_h1 : integer range 0 to 640:= 320;
signal ball_pos_v1 : integer range 0 to 480:= 240;
signal ball_up : std_logic:= '0';
signal ball_right : std_logic:= '1';
signal ball_speed_h	: integer range 0 to 15:= 5;
signal ball_speed_v	: integer range 0 to 15:= 5;

begin

clock : clock_vga port map(
       clk_in => clk,
       reset =>reset,
       clk_out => vga_clk);
       
vga : vga_controller_640_60 port map (
  rst => reset,
  pixel_clk => vga_clk,
  HS => Hsync,
  VS => Vsync,
  hcount=>hpos, 
  vcount=>vpos,
  blank=> blank);

draw_paddle : process (vga_clk) 
begin
	if (rising_edge(vga_clk)) then
		if ((hpos >= paddle_h1 and hpos < paddle_h1 + 3) and (vpos >= paddle_v1 and vpos < paddle_v1 + 40) ) then
			set_red <= "1111";
		elsif ( (hpos >= paddle_h2 and hpos < paddle_h2 + 3) and (vpos >= paddle_v2 and vpos < paddle_v2 + 40) ) then
			set_red <= "1111";
		else
			set_red <= "0000";
		end if;		
	end if;	 
end process;

draw_ball : process (vga_clk) 
begin
	if (rising_edge(vga_clk)) then
		if ( (hpos >= ball_pos_h1 and hpos < ball_pos_h1 + 8) and (vpos >= ball_pos_v1 and vpos < ball_pos_v1 + 8) ) then
			set_green <= "1111";
		else
			set_green <= "0000";
		end if;
end if;	 
end process;

fond : process (vga_clk) 
begin
    set_blue <= "1111";
end process;
  
  vgaBlue <= set_blue;
  vgaRed <= set_red ;
  vgaGreen <= "1100" ;

end Behavioral;
