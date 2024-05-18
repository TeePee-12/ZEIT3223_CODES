----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: Duty_Cycle_Inc_Or_Dec - Behavioral
-- Create Date: 20.08.2023 15:40:47
--
-- Implemetned in the RGB section of the lab
-- Controls the colour of an RGB LED, 3 chanels each a natural number 0-100 to represent relative brightness
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Colour_Control_RGB is
  Port (clk : in std_logic;
        sw0 : in std_logic;
        rst : in std_logic;
        inc0: in std_logic;   -- red increment
        dec0: in std_logic;   -- red decrement
        inc1: in std_logic;   -- green increment
        dec1: in std_logic;   -- green decrement
        inc2: in std_logic;   -- blue increment
        dec2: in std_logic;   -- blue decrement
        dc0 : out std_logic_vector(2 downto 0);    -- red output
        dc1 : out std_logic_vector(2 downto 0);    -- green output
        dc2 : out std_logic_vector(2 downto 0));   -- blue output
end Colour_Control_RGB;

architecture Behavioral of Colour_Control_RGB is

begin
G_PWM: for i in 0 to 2 generate -- Each chanel of the RGB has a PWM FSM controling its relative brightness (0-100%)
    C_PWM: entity work.Duty_Cycle_Adjust_RGB port map(clk=>clk, rst=>'0', inc=>inc(i), dec=>dec(i), DUTY_CYCLE=>dc(i));
end generate;
-- Only if sw0='1' should the state machine run, the switch position acts as an enable to chnage the output state of this machine

-- This is where the state machine code needs to be implemented.


end Behavioral;
