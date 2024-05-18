----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: sr_ff - Behavioral
-- Create Date: 26.07.2023 16:23:21
--
-- A synchronous SR Flip Flop built on the Asynchronous SR Latch in this project structure
-- Output state change on rising clock edge for synchronous inputs
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_ff is
    Port ( S  :  in STD_LOGIC;
           R  :  in STD_LOGIC;
           rst:  in STD_LOGIC; --The asynchronous reset
           clk:  in STD_LOGIC;
           Q  : out STD_LOGIC;
           Qb : out STD_LOGIC);
end sr_ff;

architecture Behavioral of sr_ff is
    signal r_r , r_s: std_logic; -- The internal input registers
    component sr_latch is 
    Port ( S  :  in STD_LOGIC;
           R  :  in STD_LOGIC;
           Q  : out STD_LOGIC;
           Qb : out STD_LOGIC);
    end component;
begin
-- Wire up the sr latch component.
-- Output ports map directly to flip flop output.
-- Inputs are connected through internal registers.
srlatch: sr_latch port map(S=>r_s, R=>r_r, Q=>Q, Qb=>Qb); 

process(clk, rst)
    -- The clocked processes
    -- Updates the input set and reset registers on a clock rising edge
    -- rst going to high forces reset state irrespective of clock
    begin
    if rst = '1' then -- Asynchronous reset
            r_s <= '0';
            r_r <= '1';
    elsif rising_edge(clk) then -- Synchronous chnages happen after here
        if S = '0' and R = '0' then -- Map zero inputs straight through
        r_s <= '0';
        r_r <= '0';
        elsif S = '1' and R = '1' then -- If S and R both go high, map zero to S and R for the synchronous update
        r_s <= '0';                    -- This prevents driving unknown states at the output
        r_r <= '0';
        elsif S = '0' and R = '1' then -- Synchrnous Reset
        r_s <= '0';
        r_r <= '1';
        elsif S = '1' and R = '0' then -- Synchronous Set
        r_s <= '1';
        r_r <= '0';
        else  -- If anything else happens, do nothing
        r_s <= r_s;
        r_r <= r_r;
        end if;
    end if;
end process;
end Behavioral;

