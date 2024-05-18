----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: sr_latch - Test bench
-- Create Date: 24.07.2023 16:19:45
--
-- Test the latching operation of the sr_latch.vhd component
------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_latch_tb is
end sr_latch_tb;

architecture Behavioral of sr_latch_tb is
    signal S, R, Q, Qb: STD_Logic;
    
component sr_latch is
    Port ( S : in STD_LOGIC;
           R : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qb : out STD_LOGIC);
end component;

begin
C_sr_latch: sr_latch port map(S=>S, R=>R, Q=>Q, Qb=>Qb);
process
-- Process tests all comninations of S and R inputs for verification in the simulation
begin
S <= '0';
R <= '1';
wait for 2 ns;
S <= '0';
R <= '0';
wait for 6 ns;
S <= '1';
R <= '0';
wait for 2 ns;
S <= '0';
R <= '0';
wait for 6 ns;
S <= '0';
R <= '1';
wait for 2 ns;
S <= '0';
R <= '0';
wait for 6 ns;
S <= '1';
R <= '1';
wait for 2 ns;
S <= '0';
R <= '0';
wait for 2 ns;
end process;
end Behavioral;
