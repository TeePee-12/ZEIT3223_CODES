----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: PWM - Behavioral
-- Create Date: 31.07.2023 17:26:10
--
-- PWM Device to drive 4 LEDs. IMplemented as a Moore Machine
-- Requires external stimulation for setting the PWM duty cycle and prividing the count
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           cnt : in STD_LOGIC_vector (7 downto 0);
           DUTY_CYCLE : in std_logic_vector (7 downto 0);
           led : out STD_LOGIC_vector (3 downto 0));
end pwm;

architecture arch of pwm is

type t_state_Moore_FSM is (LED_OFF, LED_ON);
signal r_state_moore, r_state_moore_next : t_state_moore_FSM;

begin
P_UPATE: process (clk, rst)
begin
    if rising_edge(clk)then
        if rst='1' then
            r_state_moore <= LED_OFF;
        else
        r_state_moore <= r_state_moore_next;
        end if;
    end if;
end process;

P_FSM: process(clk, r_state_moore, CNT, DUTY_CYCLE)
    begin
    case r_state_moore is
        when LED_ON =>
            if CNT < DUTY_CYCLE then
               r_state_moore_next <= r_state_moore;
            else
               r_state_moore_next <= LED_OFF ; 
       end if;
       when LED_OFF =>
           if CNT > DUTY_CYCLE then
               r_state_moore_next <= r_state_moore;
           else
               r_state_moore_next <= LED_ON;
       end if;
end case;
end process;

P_OUT: process(clk, r_state_moore, CNT, DUTY_CYCLE)
begin
    case r_state_moore is
        when LED_OFF =>
            led <= ('0','0','0','0');
        when LED_ON =>
            led <= ('1','1','1','1');
end case;
end process;
end arch;
