----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: PWM Test Bench
-- Create Date: 31.07.2023 17:26:10
--
-- PWM Device to drive 4 LEDs. Test bench provides external stimulus
-- SR counter based on FF design is utilised as the count
-- This test bench provides external stumilus of 8 bit vector for duty cycle and tests the reset function to PWM
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_class_tb is
end pwm_class_tb;
architecture Behavioral of pwm_class_tb is

signal led: std_logic_vector(3 downto 0);
signal cnt: STD_LOGIC_Vector (7 downto 0);
signal clk: std_logic := '0';
signal rst: std_logic := '0';
signal DUTY_CYCLE: std_logic_vector (7 downto 0);

    component pwm is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           cnt : in STD_LOGIC_vector (7 downto 0);
           DUTY_CYCLE : in std_logic_vector (7 downto 0);
           led : out STD_LOGIC_vector (3 downto 0));
    end component;
    
    component sr_counter is
        Port ( rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               cnt : out STD_LOGIC_Vector (8 downto 1));
    end component;
begin
    C_sr_counter: sr_counter port map(clk=>clk, rst=>rst, cnt=>cnt);
    C_PWM: PWM port map (clk=>clk, rst=>rst, cnt=>cnt, DUTY_CYCLE=>DUTY_CYCLE, led=>led);
    DUTY_CYCLE <= ('0','0','1','1','1','1','1','1');
    clk <= not clk after 1 ns;
  
    process
    begin
        rst <='1';
        wait for 1 ns;
        rst <= '0';
        wait;
    end process; 
end Behavioral;
