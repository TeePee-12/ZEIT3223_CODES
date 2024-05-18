----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: sr_latch - Behavioral
-- Create Date: 24.07.2023 16:19:45
--
--The Asynchronous component of the SR Flip Flop
--Internal Signals r_s and r_r invert the external inputs at ports S and R
--To negate the inverted input behaviour induced by NAND gate architecture 
---------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_latch is
    Port ( S : in STD_LOGIC;
           R : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qb : out STD_LOGIC);
end sr_latch;

architecture Behavioral of sr_latch is
    -- Internal signals r_q and r_Qb conncet the outputs of each NAND gate to the input of another
    -- Internal signals r_r and r_s inver the input ports S and R so that output changes only when
    -- Either are driven high from an external stimulus
    signal  r_Q, r_Qb, r_r, r_s:std_logic;
    component nand_gate is 
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           X : out STD_LOGIC);
    end component;
    begin
    nand1: nand_gate port map(X=>r_Q, A=> r_s, B=>r_Qb); -- Wire up the internal component
    nand2: nand_gate port map(X=>r_Qb, A=> r_r, B=>r_Q); -- Wire up the internal component
    Q  <= r_Q;  -- Latch Output
    Qb <= r_Qb; -- Latch Output
    r_s <= not S; -- Input Stimulus is S => Not S =>A
    r_r <= not R; -- Input Stimulus is R => Not R =>A
    
end Behavioral;
