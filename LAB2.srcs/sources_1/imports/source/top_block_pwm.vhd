----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: PWM TOP BLOCK
-- Create Date: 17.08.2023 12:06:07
--
-- Top Block utilising all components required ot run PWM on the pynq board
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_block_pwm is
Port ( 
    clk: in std_logic; -- Onboard clock on pynq board
    inc: in std_logic; -- Physical increment button
    dec: in std_logic; -- Physical decrement button
    rst: in std_logic; -- Reset condition to make simulation easier
    led: out std_logic_vector(3 downto 0)); -- physical board LEDS
end top_block_pwm;

architecture Behavioral of top_block_pwm is
    signal cnt: std_logic_vector(7 downto 0); -- 8 Bit count, provided from SR-Counter compoenent
	signal DUTY_CYCLE: std_logic_vector(7 downto 0); --Duty cycle represented as an 8 bit vetor to compare with count
	signal inc_edge, dec_edge, inc_db, dec_db: std_logic; -- Debounced button signals

begin--wire up all the different components required
    -- Create duty cycle adjuster component - button inputs mapped to button edges, which are mapped to debounce edge output.
    -- Provides an 8-bit duty cycle representation
    C_duty_cycle_adjust: entity work.duty_cycle_adjust port map(clk=>clk, rst=>rst, inc=>inc_edge, dec=>dec_edge, duty_cycle=>duty_cycle);
    -- SR Counter provides a constant 8-bit count that is clocked
    C_Counter: entity work.sr_counter port map(clk=>clk, rst=>rst, cnt=>cnt);
    -- PWM - comapres the duty cycle to the count to turn LEDs on and off
	C_PWM: entity work.pwm port map (clk=>clk, rst=>rst, duty_cycle=>duty_cycle, led=>led, cnt=>cnt); 
	--2 debouce components, one for each button inc and dec.
    C_debouce_dec: entity work.debounce port map(i_clk=>clk, i_rst=>rst, i_btn=>dec, o_btn_db=>dec_db, o_btn_edge=>dec_edge);
    C_debouce_inc: entity work.debounce port map(i_clk=>clk, i_rst=>rst, i_btn=>inc, o_btn_db=>inc_db, o_btn_edge=>inc_edge); 

end Behavioral;
