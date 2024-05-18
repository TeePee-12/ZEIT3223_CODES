----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: PWM TOP BLOCK
-- Create Date: 17.08.2023 12:06:07
--
-- Test bench to simulate the entire PWM entity running on a board
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity top_block_pwm_tb is
end top_block_pwm_tb;

architecture Behavioral of top_block_pwm_tb is
    signal rst, clk, inc, dec: std_logic :='0'; -- Onboard clock and buttons on pynq board
    signal led: std_logic_vector(3 downto 0); -- physical board LEDS

    component top_block_pwm is
    Port ( clk : in STD_LOGIC;
           inc : in STD_LOGIC;
           dec : in std_logic;
           rst : in std_logic;
           led : out STD_LOGIC_vector (3 downto 0));
    end component;
begin
C_top_block_pwm: top_block_pwm port map(clk=>clk, inc=>inc, dec=>dec, led=>led, rst=>rst);
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
end Behavioral;
