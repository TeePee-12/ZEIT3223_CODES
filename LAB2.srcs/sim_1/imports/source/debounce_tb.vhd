-- Written by Edwin Peters
-- ZEIT3223 Embedded Systems
-- The University of New South Wales Canberra
-- 2023

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce_tb is
--  Port ( );
end debounce_tb;

architecture Behavioral of debounce_tb is
    signal clk, rst : std_logic := '0';

    signal btn, btn_db, btn_edge : std_logic;
    signal hold: std_logic := '1';
    
begin
    C_DUT: entity work.debounce generic map(g_delay_count => 50) port map(i_clk => clk, i_rst => rst, i_btn => btn, o_btn_db => btn_db, o_btn_edge => btn_edge);

    clk <= not clk after 0.5 ns;
    
    P_DUT: process
    begin
        wait for 1 ns;
        rst <= '1';
        wait for 2 ns;
        rst <= '0';
        wait for 1 ns;
        btn <= '1';
        wait for 5 ns;
        btn <= '0';
        wait for 7 ns;
        btn <= '1';
        wait for 3 ns;
        btn <= '0';
        wait for 5 ns;
        btn <= hold;
        hold <= not hold;
        wait for 50 ns;
        btn <= '0';
        wait for 100 ns;
        
    end process;
    
 

end Behavioral;
