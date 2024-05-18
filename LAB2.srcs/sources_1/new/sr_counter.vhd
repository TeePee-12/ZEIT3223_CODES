----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: sr_counter - Behavioral
-- Create Date: 31.07.2023 17:26:10
--
-- Test the latching operation of the sr_latch.vhd component
-- Uses Generate statement and "work.sr_ff" syntax to ustilise exisitng component in project structure
-- Each SR FF output Qb is connected to input clock pulse of the next one, and is also looped back into "S" of its own input
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cnt : out STD_LOGIC_VECTOR (8 downto 1));
end sr_counter;

architecture behavioural of sr_counter is

signal r_Q, r_Qb : STD_Logic_vector (8 downto 0); -- Registers for interconnecting FFs and holding output values
component sr_ff is 
    Port ( S  :  in STD_LOGIC;
           R  :  in STD_LOGIC;
           clk:  in STD_LOGIC;
           rst:  in STD_LOGIC;
           Q  : out STD_LOGIC;
           Qb : out STD_LOGIC );
    end component;
begin
r_Qb(0) <= clk; -- Declare that the clock pulse drives the input of first counter
cnt<=r_Q(8 downto 1); -- These are te output bits used to represent the counnt in binary
G_COUNTER: for i in 1 to 8 generate --This is where our 8 SR FFs are generated
    C_COUNT: entity work.sr_ff port map(Q=>r_Q(i), R=>r_Q(i), Qb=>r_Qb(i), S=>r_Qb(i), clk=> r_Qb(i-1), rst=>rst); -- Mapping the FFs together as they generate
end generate;

end behavioural;