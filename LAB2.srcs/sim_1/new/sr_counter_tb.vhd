
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_counter_tb is
end sr_counter_tb;

architecture Behavioral of sr_counter_tb is
    signal clk, rst : std_logic :='1'; -- initialise with asynchrnous reset
    signal cnt : std_logic_vector(7 downto 0);
    
    component sr_counter is
    Port ( clk, rst : in STD_LOGIC;
           cnt : out STD_LOGIC_Vector(7 downto 0));
end component;

begin
clk <= not clk after 1 ns;
C_sr_counter: sr_counter port map(clk=>clk, rst=>rst,cnt=>cnt);

process
    begin
    wait for 1 ns;
    rst <= '0';
    wait for 60 ns; -- droop the reset to zero, count for 25 ns then test the reset
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait for 520 ns; -- Test the full count afer dropping the reset again
end process;

end Behavioral;
