library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pong is
    Port ( clk : in STD_LOGIC;
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           digit_OUT : out STD_LOGIC_VECTOR (6 downto 0);
           digit_choice : out STD_LOGIC_VECTOR (3 downto 0);
           PS2Clk : in STD_LOGIC;
           PS2Data : in STD_LOGIC
           );
end pong;

architecture Behavioral of pong is
--touche up joueur droite : Z 
constant down_j2 : STD_LOGIC_VECTOR(7 downto 0) := X"1D";
--touche down joueur droitre : S 
constant up_j2 : STD_LOGIC_VECTOR(7 downto 0) := X"1B";
--touche up joueur  Gauche: O
constant down_j1 : STD_LOGIC_VECTOR(7 downto 0) := X"44";
--touche down joueur gauche : L 
constant up_j1 : STD_LOGIC_VECTOR(7 downto 0) := X"4B";

-- Bouton reset
constant R_but : STD_LOGIC_VECTOR(7 downto 0) := X"2D";

component score is
port ( scoreJ1 : in integer range 0 to 99;
       scoreJ2 : in integer range 0 to 99;
       digit_OUT : out STD_LOGIC_VECTOR (6 downto 0);
       digit_choice : out STD_LOGIC_VECTOR (3 downto 0);
       CLK : in STD_LOGIC);
end component;

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
           balle_v : in integer range 0 to 800;
           scoreJ1 : in integer range 0 to 99;
           scoreJ2 : in integer range 0 to 99
           );
end component;

component ps2_keyboard IS
    PORT(
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --code received from PS/2
end component;

component boutton is
    Port ( ps2_code_new : in STD_LOGIC;
           ps2_code : in STD_LOGIC_VECTOR (7 downto 0);
           code_on : in STD_LOGIC_VECTOR (7 downto 0);
           signal_button : out STD_LOGIC);
end component;   

component paddle_driver is
    Port ( vga_clk : in STD_LOGIC;
            paddle_speed : in integer range 0 to 15:= 4;
            new_frame : in std_logic;
            p_up : in STD_LOGIC;
            p_down : in STD_LOGIC;
            pos_paddle : out integer range 0 to 800;
            reset : in STD_LOGIC);
end component;        
           
signal vga_clk : std_logic:='0'; 
signal rst : std_logic:='0'; 
signal hpos : std_logic_vector(10 downto 0):= (others => '0');
signal vpos : std_logic_vector(10 downto 0):= (others => '0');
signal blank : std_logic:='0';
signal new_frame : std_logic:='0';

signal paddle_h1 : integer range 0 to 800:= 600;
signal paddle_v1 : integer range 0 to 800:= 220;
signal paddle_h2 : integer range 0 to 800:= 30;
signal paddle_v2 : integer range 0 to 800:= 220;
signal paddle_speed	: integer range 0 to 15:= 4;

signal ball_pos_h1 : integer range 0 to 800:= 318;
signal ball_pos_v1 : integer range 0 to 800:= 238;
signal ball_up : std_logic:= '0';
signal ball_right : std_logic:= '1';
signal ball_speed_h	: integer range 0 to 5:= 2;
signal ball_speed_v	: integer range 0 to 5:= 2;

signal scoreJ1	: integer range 0 to 99:= 0;
signal scoreJ2	: integer range 0 to 99:= 0;
signal ps2_code : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ps2_code_new : std_logic;
signal p1_up :  STD_LOGIC := '0';
signal p1_down : STD_LOGIC :='0';
signal p2_up :  STD_LOGIC := '0';
signal p2_down : STD_LOGIC :='0';


signal reset : STD_LOGIC :='0';
begin

clock : clock_vga port map(
       clk_in => clk,
       reset =>'0',
       clk_out => vga_clk);

       
vga : vga_controller_640_60 port map (
  rst => '0',
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
	blank =>blank,
	rouge=>vgaRed,
	vert=>vgaGreen,
	bleu=>vgaBlue,
	paddle_h1=>paddle_h1,
	paddle_v1=>paddle_v1,
	paddle_h2=>paddle_h2,
	paddle_v2=>paddle_v2,
	balle_h=>ball_pos_h1,
	balle_v=>ball_pos_v1,
	scoreJ1 => scoreJ1,
    scoreJ2 => scoreJ2);

scoreDigit : score port map(
    scoreJ1 => scoreJ1,
    scoreJ2 => scoreJ2,
    digit_OUT => digit_OUT,
    digit_choice => digit_choice,
    CLK =>clk);
    
ps2 : ps2_keyboard port map(
        ps2_clk=> PS2Clk,
        ps2_data => PS2Data,
        ps2_code_new =>ps2_code_new,
        ps2_code =>ps2_code);

b_up_1 : boutton port map ( ps2_code_new =>ps2_code_new,
           ps2_code => ps2_code,
           code_on => up_j1,
           signal_button => p1_up);

b_down_1 : boutton port map ( ps2_code_new =>ps2_code_new,
           ps2_code => ps2_code,
           code_on => down_j1,
           signal_button => p1_down) ;
           
b_up_2 : boutton port map ( ps2_code_new =>ps2_code_new,
                      ps2_code => ps2_code,
                      code_on => up_j2,
                      signal_button => p2_up);
                      
b_reset : boutton port map ( ps2_code_new =>ps2_code_new,
            ps2_code => ps2_code,
            code_on => R_but,
            signal_button => reset);
           
b_down_2 : boutton port map ( ps2_code_new =>ps2_code_new,
    ps2_code => ps2_code,
    code_on => down_j2,
    signal_button => p2_down) ;           
paddle_j1 : paddle_driver port map(vga_clk=>vga_clk,paddle_speed=>paddle_speed,new_frame=>new_frame,
    p_up=>p1_up,p_down=>p1_down,pos_paddle=>paddle_v1,reset=>reset);
paddle_j2 : paddle_driver port map(vga_clk=>vga_clk,paddle_speed=>paddle_speed,new_frame=>new_frame,
    p_up=>p2_up,p_down=>p2_down,pos_paddle=>paddle_v2,reset=>reset);                      

move_ball : process (vga_clk,new_frame) 
begin
 
	if (rising_edge(vga_clk) and new_frame = '1') then
	   if (reset = '1') then
    	   ball_pos_v1 <= 218;
		   ball_pos_h1 <= 318;
		  --- ball_speed_v <=2;
		   scoreJ1 <= 0;
		   scoreJ2<=0;
    	else
			if (ball_pos_v1 < 469 and ball_up = '1') then
				ball_pos_v1 <= ball_pos_v1 + ball_speed_v;
			elsif (ball_up = '1') then
				ball_up <= '0';
			elsif (ball_pos_v1 > 3 and ball_up = '0') then
				ball_pos_v1 <= ball_pos_v1 - ball_speed_v;
			elsif (ball_up = '0') then
				ball_up <= '1';
			end if;
			
			if (ball_pos_h1 < 628 and ball_right = '1') then
				ball_pos_h1 <= ball_pos_h1 + ball_speed_h;
			elsif (ball_right = '1') then
			    scoreJ2 <= scoreJ2 + 1; 
				ball_right	<= '0';
				ball_pos_v1 <= 238;
                ball_pos_h1 <= 318;    			
			elsif (ball_pos_h1 > 4 and ball_right = '0') then
				ball_pos_h1 <= ball_pos_h1 - ball_speed_h;
			elsif (ball_right = '0') then
			    scoreJ1 <= scoreJ1+1; 
				ball_right <= '1';
				ball_pos_v1 <= 238;
                ball_pos_h1 <= 318;			
			end if;
		end if;
	end if;
	if (rising_edge(vga_clk) and new_frame = '1') then
        if(ball_pos_h1 <= (paddle_h1 + 5) and (ball_pos_h1+3) > paddle_h1 and ball_pos_v1 >= paddle_v1 and ball_pos_v1 < (paddle_v1+40) )  then
            ball_right <= '0'; 
            if((p1_up = '1' and ball_up = '1') or (p1_down ='0' and ball_up ='0' )) then                
                if(ball_speed_v > 1)then
                    ball_speed_v <= ball_speed_v -1;
                end if;
            elsif((p1_up = '1' and ball_up = '0') or (p1_down ='0' and ball_up ='1'))then
                if(ball_speed_v <4) then
                    ball_speed_v <= ball_speed_v + 1;
                end if;
            end if;
        end if;
        if((ball_pos_h1 +3) >= paddle_h2 and ball_pos_h1 < (paddle_h2+5) and ball_pos_v1 >= (paddle_v2) and ball_pos_v1 < (paddle_v2+40)) then
            ball_right <= '1';
             if((p2_up = '1' and ball_up = '1') or (p2_down ='0' and ball_up ='0' )) then
                  if(ball_speed_v > 1)then
                      ball_speed_v <= ball_speed_v -1;
                   end if;
             elsif((p2_up = '1' and ball_up = '0') or (p2_down ='0' and ball_up ='1'))then
                 if(ball_speed_v < 4) then 
                     ball_speed_v <= ball_speed_v + 1;
                  end if;
             end if;
        end if;			
	end if;
		 
end process;

end Behavioral;
