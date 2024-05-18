----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 14:55:40
-- Design Name: 
-- Module Name: RGB_BRIGHTNESS - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RGB_BRIGHTNESS is
  Port (clk : in std_logic;
        sw1 : in std_logic;
        i_rgb0 : in std_logic_vector(2 downto 0);
        i_rgb1 : in std_logic_vector(2 downto 0);
        i_rgb2 : in std_logic_vector(2 downto 0);
        i_rgb3 : in std_logic_vector(2 downto 0);
        i_rgb4 : in std_logic_vector(2 downto 0);
        i_rgb5 : in std_logic_vector(2 downto 0);
        o_rgb0 : out std_logic_vector(7 downto 0);
        o_rgb1 : out std_logic_vector(7 downto 0);
        o_rgb2 : out std_logic_vector(7 downto 0);
        o_rgb3 : out std_logic_vector(7 downto 0);
        o_rgb4 : out std_logic_vector(7 downto 0);
        o_rgb5 : out std_logic_vector(7 downto 0));                                             
end RGB_BRIGHTNESS;

architecture Behavioral of RGB_BRIGHTNESS is
signal cnt : std_logic_vector(7 downto 0);
signal duty_cycle : std_logic_vector(7 downto 0);
signal rst : std_logic :='0';
signal pwm : std_logic;
begin
-- SR Counter provides a constant 8-bit count that is clocked
-- Some FSM state is programmed in this sec
C_Counter: entity work.sr_counter port map(clk=>clk, rst=>rst, cnt=>cnt);
C_PWM: entity work.pwm port map (clk=>clk, rst=>rst, duty_cycle=>duty_cycle, led(0)=>pwm, cnt=>cnt);

-- Some FSM state is programmed in this section such that when sw1 is high the Duty_Cyle value is swept automatically
--        fromm 0-255 and back at a pre-set rate, so the user can turn the switch when the desired brightnesss is acheived

-- The output part of the FSM will apply some mathematical operation between the number held in each i_rgb[i] signal and the output PWM of this FSM
-- The resulting PWM value is output for each RGB in o_rgb[i]
end Behavioral;
