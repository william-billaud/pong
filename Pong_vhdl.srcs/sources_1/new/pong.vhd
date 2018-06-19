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
           PS2Data : in STD_LOGIC;
           sw: in STD_LOGIC;
           speaker : out STD_LOGIC
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
    in_progress : in std_logic;
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


component move_ball is
    Port (
      vga_clk : in STD_LOGIC;
      new_frame : in STD_LOGIC;
      reset : in STD_LOGIC;
      paddle_h1 : in integer range 0 to 800;
      paddle_v1 : in integer range 0 to 800;
      paddle_h2 : in integer range 0 to 800;
      paddle_v2 : in integer range 0 to 800;
      p1_up : in STD_LOGIC := '0';
      p1_down : in STD_LOGIC :='0';
      p2_up : in  STD_LOGIC := '0';
      p2_down : in STD_LOGIC :='0';
      hBalle : out integer range 0 to 800;
      vBalle : out integer range 0 to 800;
      scoreJ1_out    : out integer range 0 to 99;
      scoreJ2_out : out integer range 0 to 99
     );
end component;

component buzzer is
    Port ( 
      CLK : in STD_LOGIC;
      sw: in STD_LOGIC;
      speaker : out STD_LOGIC
    );
end component;

component chrono is
    Port ( clk : in STD_LOGIC; 
            reset : in std_logic;  
            sec : out integer range 0 to 59;
            min : out integer range 0 to 3;
            in_progress : out STD_LOGIC);
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


signal scoreJ1	: integer range 0 to 99:= 0;
signal scoreJ2	: integer range 0 to 99:= 0;
signal ps2_code : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ps2_code_new : std_logic;
signal p1_up :  STD_LOGIC := '0';
signal p1_down : STD_LOGIC :='0';
signal p2_up :  STD_LOGIC := '0';
signal p2_down : STD_LOGIC :='0';

signal in_progress : std_logic;
signal sec : integer range 0 to 59;
signal min : integer range 0 to 3;

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
  
frame : frame_c port map(hpos=>hpos,vpos=>vpos,in_progress=> in_progress,new_frame=>new_frame);

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
    scoreJ1 => sec,
    scoreJ2 => min,
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


deplacement_balle : move_ball port map(
    vga_clk=>vga_clk,
    new_frame=>new_frame,
    reset=>reset,
    paddle_h1=>paddle_h1,
    paddle_v1=>paddle_v1,
    paddle_h2=>paddle_h2,
    paddle_v2=>paddle_v2,
    p1_up=>p1_up,
    p1_down=>p1_down,
    p2_up=>p2_up,
    p2_down=>p2_down,
    hBalle=>ball_pos_h1,
    vBalle=>ball_pos_v1,
    scoreJ1_out=> scoreJ1,
    scoreJ2_out=> scoreJ2);

musique: buzzer port map(CLK=>clk,sw=>sw,speaker=>speaker);
timer : chrono port map(clk=>clk,
    reset => reset,
    sec => sec,
    min => min,
    in_progress => in_progress);

end Behavioral;
