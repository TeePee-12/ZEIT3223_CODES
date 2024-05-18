----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: sr_ff - Test Bench
-- Create Date: 26.07.2023 16:23:21
--
-- Test bench for the sr_ff.vhd component
-- Test bench generates a clock pulse and tests all possible S and R logic vombinations
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_ff_tb is
end sr_ff_tb;

architecture Behavioral of sr_ff_tb is
    signal Q, Qb: STD_Logic;
    signal S, R, clk: std_logic := '0' ; --initialisa at zero state for test bench
    signal rst: std_logic := '1'; -- initialise in reset mode to avoid any undefined outputs
    
component sr_ff is
   Port (  S  :  in STD_LOGIC;
           R  :  in STD_LOGIC;
           clk:  in STD_LOGIC;
           rst:  in STD_LOGIC;
           Q  : out STD_LOGIC;
           Qb : out STD_LOGIC);
end component;

begin
clk <= not clk after 1 ns; -- creates a 500 MHz clock
C_sr_ff: sr_ff port map(S=>S, R=>R, Q=>Q, Qb=>Qb, clk=>clk, rst=>rst);
process
begin
wait for 2 ns;
S <= '1';       --set while asynchronous reset held high
R <= '0'; 
wait for 2 ns;
S <= '0';
R <= '1';       --reset while asynchronous reset held high
wait for 2 ns;
rst <= '0';    -- drop reset after testing to verify reset ovverides synchrnous operation
wait for 10 ns;
S <= '1';       --set
R <= '0'; 
wait for 2 ns;
S <= '0';
R <= '0';
wait for 10 ns;
S <= '0';
R <= '1';       --reset
wait for 2 ns;
S <= '0';
R <= '0';
wait for 10 ns;
S <= '1';       --test R and S driven high condition
R <= '1'; 
wait for 2 ns;
S <= '0';
R <= '0';
wait for 15 ns;
S <= '1';       --set
R <= '0';
wait for 2 ns;
S <= '0';
R <= '0';
wait for 10 ns;
S <= '1';      --reset
R <= '0';
wait for 2 ns;
S <= '0';
R <= '0';
wait for 5 ns;
rst <= '1';      --asynchrnous reset
wait for 1 ns;
rst <= '0';
wait for 2 ns;
S <= '0';
R <= '0';
end process;
end Behavioral;
