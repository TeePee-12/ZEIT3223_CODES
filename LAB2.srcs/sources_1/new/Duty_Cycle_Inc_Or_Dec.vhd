----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: Duty_Cycle_Inc_Or_Dec - Behavioral
-- Create Date: 20.08.2023 15:40:47
--
-- Implemetned in the RGB section of the lab
-- State of this machine will control whether increment of PWM adjust goes up or down
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Duty_Cycle_Inc_Or_Dec is
    Port ( clk :    in STD_LOGIC;
           but_3 :  in STD_LOGIC; -- change state between increment/decremetn
           but : in STD_LOGIC; -- input from a PWM adjust button
           inc :    out STD_LOGIC; -- output from PWM adjust button when state is increment
           dec :    out STD_LOGIC; -- output from PWM adjust button when state is decrement
           led_ind :out std_logic); -- '1' when state is increment for the indicator LED
end Duty_Cycle_Inc_Or_Dec;

architecture Behavioral of Duty_Cycle_Inc_Or_Dec is
    type t_state_Moore_DC is (Increase, Decrease); -- D_0 through D_100 are duty cycle percentages
    signal r_state_current, r_state_next : t_state_Moore_DC;
begin

P_UPATE: process (clk)
begin
    if rising_edge(clk)then
        r_state_current <= r_state_next;
    end if;
end process;

P_DC: process(clk, r_state_current, but_3)
    begin
    case r_state_current is
        when Increase =>
            if but_3 = '1' then
               r_state_next <= Decrease;
            else
               r_state_next <= r_state_current;
       end if;
       when Decrease =>
           if but_3 = '1' then
               r_state_next <= Increase;
           else
               r_state_next <= r_state_current;
       end if;
end case;
end process;

P_OUT: process(clk, r_state_current, but_3, dc_adj)
begin
    case r_state_current is
        when Increase =>
            led_ind <= '1';
            if dc_adj = '1' then
                inc <= '1';
                dec <= '0';
            else
                inc <= '0';
                dec <= '0';
            end if;
        when Decrease =>
            led_ind <= '0';
            if dc_adj = '1' then
                inc <= '0';
                dec <= '1';
            else
                inc <= '0';
                dec <= '0';
            end if;
end case;
end process;
end Behavioral;
