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

component frame_c is
	Port ( hpos : in std_logic_vector(10 downto 0);
	vpos : in std_logic_vector(10 downto 0);
	new_frame : out STD_LOGIC);
end component;

component RGB_controller is
    Port ( hpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           vpos : in STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
           blank : in STD_LOGIC:= '0';
           rouge : out STD_LOGIC_VECTOR (3 downto 0);
           vert : out STD_LOGIC_VECTOR (3 downto 0);
           bleu : out STD_LOGIC_VECTOR (3 downto 0);
           paddle_h1 : in integer range 0 to 800 ;
           paddle_v1 : in integer range 0 to 800;
           paddle_h2 : in integer range 0 to 800;
           paddle_v2 : in integer range 0 to 800;
           balle_h : in integer range 0 to 800;
           balle_v : in integer range 0 to 800);
end component;

signal vga_clk : std_logic:='0'; 
signal rst : std_logic:='0'; 
signal set_red, set_green, set_blue : std_logic_vector(3 downto 0):= (others => '0');
signal hpos : std_logic_vector(10 downto 0);
signal vpos : std_logic_vector(10 downto 0);
signal blank : std_logic:='0';
signal new_frame : std_logic:='0';

signal paddle_h1 : integer range 0 to 800:= 600;
signal paddle_v1 : integer range 0 to 800:= 220;
signal paddle_h2 : integer range 0 to 800:= 30;
signal paddle_v2 : integer range 0 to 800:= 220;
signal paddle_speed	: integer range 0 to 15:= 2;

signal ball_pos_h1 : integer range 0 to 800:= 318;
signal ball_pos_v1 : integer range 0 to 800:= 238;
signal ball_up : std_logic:= '0';
signal ball_right : std_logic:= '1';
signal ball_speed_h	: integer range 0 to 15:= 2;
signal ball_speed_v	: integer range 0 to 15:= 2;

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
frame : frame_c port map(hpos=>hpos,vpos=>vpos,new_frame=>new_frame);
rgb : RGB_controller port map(
	hpos=>hpos,
	vpos=>vpos,
	blank =>blank,rouge=>vgaRed,
	vert=>vgaGreen,bleu=>vgaBlue,
	paddle_h1=>paddle_h1,
	paddle_v1=>paddle_v1,
	paddle_h2=>paddle_h2,paddle_v2=>paddle_v2,
	balle_h=>ball_pos_h1,balle_v=>ball_pos_v1);

move_paddle : process (vga_clk) 
begin
 
	if (rising_edge(vga_clk) and new_frame = '1') then
		
		if (p1_up = '1') then  
			if (paddle_v2 < 440) then
				paddle_v2 <= paddle_v2 + paddle_speed;
			end if;
		elsif ( p1_down = '1') then  
			if (paddle_v2 > 0) then
				paddle_v2 <= paddle_v2 - paddle_speed;
			end if;
		end if;
		
		if (p2_up = '1') then
			if (paddle_v1 < 440) then
				paddle_v1 <= paddle_v1 + paddle_speed;
			end if;
		elsif (p2_down = '1') then
			if (paddle_v1 > 0) then
				paddle_v1 <= paddle_v1 - paddle_speed;
			end if;
		end if;
			
	end if;
		 
end process;

move_ball : process (vga_clk) 
begin
 
	if (rising_edge(vga_clk) and new_frame = '1') then
	   if (reset = '1') then
    	   ball_pos_v1 <= 218;
		   ball_pos_h1 <= 318;
    	else
			--If ball travelling up, and not at top
			if (ball_pos_v1 < 475 and ball_up = '1') then
				ball_pos_v1 <= ball_pos_v1 + ball_speed_v;
			--If ball travelling up and at top
			elsif (ball_up = '1') then
				ball_up <= '0';
			--Ball travelling down and not at bottom
			elsif (ball_pos_v1 > 0 and ball_up = '0') then
				ball_pos_v1 <= ball_pos_v1 - ball_speed_v;
			--Ball travelling down and at bottom
			elsif (ball_up = '0') then
				ball_up <= '1';
			end if;
			
			--If ball travelling right, and not far right
			if (ball_pos_h1 < 630 and ball_right = '1') then
				ball_pos_h1 <= ball_pos_h1 + ball_speed_h;
			--If ball travelling right and at far right
			elsif (ball_right = '1') then
				ball_right	<= '0';
				ball_pos_v1 <= 238;
                ball_pos_h1 <= 318;    			
			--Ball travelling left and not at far left
			elsif (ball_pos_h1 > 10 and ball_right = '0') then
				ball_pos_h1 <= ball_pos_h1 - ball_speed_h;
			--Ball travelling left and at far left
			elsif (ball_right = '0') then
				ball_right <= '1';
				ball_pos_v1 <= 238;
                ball_pos_h1 <= 318;			
			end if;
		end if;
	end if;
	if (rising_edge(vga_clk) and new_frame = '1') then
        --if (set_blue = "1111" and set_red = "1111") then
        --   ball_right <= ball_right XOR '1'; 
        --end if;
        if(ball_pos_h1 <= (paddle_h1 + 5) and (ball_pos_h1+3) > paddle_h1 and ball_pos_v1 >= paddle_v1 and ball_pos_v1 < (paddle_v1+40) )  then
            ball_right <= '0'; 
        end if;
        if((ball_pos_h1 +3) >= paddle_h2 and ball_pos_h1 < (paddle_h2+5) and ball_pos_v1 >= (paddle_v2) and ball_pos_v1 < (paddle_v2+40)) then
            ball_right <= '1';
        end if;			
	end if;
		 
end process;

end Behavioral;
