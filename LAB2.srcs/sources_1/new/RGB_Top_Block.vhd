----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: RGB_Top_Block - Behavioral
-- Create Date: 20.08.2023 09:59:08
--
-- Top Block utilising all components required to do things with the RGB lights on pynq board
------------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RGB_Top_Block is
  Port (clk: in std_logic;
        sw0: in std_logic;
        sw1: in std_logic;
        btn: in std_logic_vector (0 to 3); -- push button inputs
        led: out std_logic_vector (0 to 3); --led outputs
        rgb: out std_logic_vector (0 to 5)); --rgb outputs
end RGB_Top_Block;

architecture Behavioral of RGB_Top_Block is
signal r_btn : STD_Logic_vector (3 downto 0); -- Registers for debounbced button inputs
signal r_inc : STD_Logic_vector (2 downto 0); -- Registers for each button increment signal
signal r_dec : STD_Logic_vector (2 downto 0); -- Registers for each button decrement signal
signal r_rgb0: STD_Logic_vector (2 downto 0); -- Registers for relative RGB chanel brightness
signal r_rgb1: STD_Logic_vector (2 downto 0);
signal r_rgb2: STD_Logic_vector (2 downto 0);
signal r_rgb3: STD_Logic_vector (2 downto 0);
signal r_rgb4: STD_Logic_vector (2 downto 0);
signal r_rgb5: STD_Logic_vector (2 downto 0);
signal rst :STD_Logic :='0';
signal sw0_b:STD_Logic; -- register to hold inverse of sw0 - to only enable one RGB to change colour at a time

begin
sw0_b <= not sw0;
--Each input button gets a debounce
G_Debounce: for i in 0 to 3 generate
    C_Debounce: entity work.debounce port map(i_clk=>clk, i_rst=>'0', i_btn=>btn[i], o_btn_edge[i]=>r_btn[i]); 
end generate;
-- Each of the 3 buttons for R,G,B channel adjust goes through and INC_OR_DEC FSM to output inc or dec signal based on selection
G_Duty_Cycle_Inc_Or_Dec: for i in 0 to 2 generate
    C_DC_INC_DEC: entity work.Duty_Cycle_Inc_Or_Dec port map(clk=>clk, but_3=>r_btn(3), but=>r_btn[i], inc=>r_inc[i], dec=>r_dec[i], led_ind=>led(3));
end generate;
-- One RGB colou FSM for ach RGB LED, 3 channels from each one, sets relative brightness.
C_RGB_Colour_0: entity work.colour_control_rgb port map(clk=>clk, sw0=>sw0, rst=>rst, 
                                                        inc0=>r_inc(0), inc1=>r_inc(1), inc2=>r_inc(2),
                                                        dec0=>r_dec(0), dec1=>r_dec(1), dec2=>r_dec(2),
                                                        dc0=>r_rgb0, dc1=>r_rgb1, dc2=>r_rgb2);
                                                        
 C_RGB_Colour_1: entity work.colour_control_rgb port map(clk=>clk, sw0=>sw0_b, rst=>rst, 
                                                        inc0=>r_inc(0), inc1=>r_inc(1), inc2=>r_inc(2),
                                                        dec0=>r_dec(0), dec1=>r_dec(1), dec2=>r_dec(2),
                                                        dc0=>r_rgb3, dc1=>r_rgb4, dc2=>r_rgb5);    

-- Final block to set global brightness of RGB leds, maintains relative brightness of each channel as set above.
C_Brightness: entity work.RGB_Brightness port map(clk=>clk, sw1=>sw1,
                                              i_rgb0=>r_rgb0, i_rgb1=>r_rgb1, i_rgb2=>r_rgb2,
                                              i_rgb3=>r_rgb3, i_rgb4=>r_rgb4, i_rgb5=>r_rgb5,
                                              o_rgb0=>rgb(0), o_rgb1=>rgb(1), o_rgb2=>rgb(2),
                                              o_rgb3=>rgb(3), o_rgb4=>rgb(4), o_rgb5=>rgb(5)
                                              );                                                                                                         
end Behavioral;
