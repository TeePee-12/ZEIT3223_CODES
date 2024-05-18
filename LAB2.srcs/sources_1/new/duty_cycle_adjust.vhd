----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: duty_cycle_adjust - Behavioral
-- Create Date: 17.08.2023 10:55:07
--
-- Mealy State Machine used to set the duty cycle of the PWM machine
-- Requires external stimulation for chanign between states
-- Requires a debounce on the physical decremetn and increment inputs to function properly
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity duty_cycle_adjust is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           inc : in STD_LOGIC;
           dec : in STD_LOGIC;
           DUTY_CYCLE :out std_logic_vector (7 downto 0)); -- We are using an 8-bit PWM machine
end duty_cycle_adjust;

architecture arch of duty_cycle_adjust is
    type t_state_Mealy_FSM is (D_0, D_25, D_50, D_75, D_100); -- D_0 through D_100 are duty cycle percentages
    signal r_state_current, r_state_next : t_state_Mealy_FSM;

begin

P_STATE_UPDATE: process(clk, rst) --state updates on the clock pulse
begin
    if rst = '1' then
        r_state_current <= D_0;
    elsif rising_edge(clk)then
        r_state_current <= r_state_next;
    end if;
end process;

P_FSM: process(r_state_current, inc, dec) -- Change of state triggered by external signals in this section
begin
    r_state_next <= r_state_current;
    
    case r_state_current is
    when D_0 =>
        if inc = '1' then
        r_state_next <= D_25;
        DUTY_CYCLE <= ('0','0','0','1','1','1','1','1');
        elsif dec = '1' then
        r_state_next <= D_0; -- stay at zero
        DUTY_CYCLE <= ('0','0','0','0','0','0','0','0');
     end if;
     when D_25 =>
        if inc = '1' then
        r_state_next <= D_50;
        DUTY_CYCLE <= ('0','0','1','1','1','1','1','1');
        elsif dec = '1' then
        r_state_next <= D_0;
        DUTY_CYCLE <= ('0','0','0','0','0','0','0','0');
     end if; 
     when D_50 =>
        if inc = '1' then
        r_state_next <= D_75;
        DUTY_CYCLE <= ('0','1','1','1','1','1','1','1');
        elsif dec = '1' then
        r_state_next <= D_25;
        DUTY_CYCLE <= ('0','0','0','1','1','1','1','1');
    end if;   
    when D_75 =>
        if inc = '1' then
        r_state_next <= D_100;
        DUTY_CYCLE <= ('1','1','1','1','1','1','1','1');
        elsif dec = '1' then
        r_state_next <= D_50;
        DUTY_CYCLE <= ('0','0','1','1','1','1','1','1');
    end if;
    when D_100 =>
        if inc = '1' then
        r_state_next <= D_100; -- stay at maximum
        DUTY_CYCLE <= ('1','1','1','1','1','1','1','1');
        elsif dec = '1' then
        r_state_next <= D_75;
        DUTY_CYCLE <= ('0','1','1','1','1','1','1','1');
    end if;
end case;
end process;
end arch;
