----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: duty_cycle_adjust - Behavioral
-- Create Date: 17.08.2023 10:55:07
--
-- Mealy State Machine used to set the duty cycle of the PWM machine
-- Test bench inputs increment and decrement signals to mealy machine
------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity duty_cycle_adjust_tb is

end duty_cycle_adjust_tb;

architecture tb of duty_cycle_adjust_tb is
  signal clk, rst : std_logic := '0';
  signal inc, dec : std_logic := '0';
  signal duty_cycle: std_logic_vector(7 downto 0);

begin
  DUT: entity work.duty_cycle_adjust port map(clk => clk, rst => rst, inc => inc, dec => dec, duty_cycle => duty_cycle);
  clk <= not clk after 1 ns;

  process
  begin
    rst <= '1';
    wait for 2.3 ns;
    rst <= '0';
    -- should stay at 0
    dec <= '1';
    wait for 2 ns;
    dec <= '0';
    wait for 20 ns;
    for ii in 0 to 6 loop -- Simulate pushing the increment button repeatedly
      inc <= '1';
      wait for 2 ns;
      inc <= '0';
      
      wait for 20 ns;
    end loop;
    
    for ii in 0 to 6 loop -- Simulate pushing the decrement button repeatedly
      dec <= '1';
      wait for 4 ns;
      dec <= '0';
      
      wait for 200 ns;
    end loop;
    
  end process;
end tb;
