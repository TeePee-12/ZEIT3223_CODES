-- Written by Edwin Peters
-- ZEIT3223 Embedded Systems
-- The University of New South Wales Canberra
-- 2023

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
Generic (
    g_delay_count: natural := 125 -- 1 us at 125 MHz
);
Port (
    i_clk: in std_logic;
    i_rst: in std_logic;
    i_btn: in std_logic;
    o_btn_db: out std_logic;
    o_btn_edge: out std_logic
 );
end debounce;

architecture Behavioral of debounce is
    type t_state_debounce is (state_idle, state_edge, state_delay, state_end);
    signal state_debounce, next_state_debounce: t_state_debounce := state_idle;
    signal r_count: natural range 0 to g_delay_count := 0;
    signal r_count_next: natural range 0 to g_delay_count;

begin

P_CLK: process(i_clk, i_rst)
    begin
        if i_rst='1' then
            state_debounce <= state_idle;
        elsif rising_edge(i_clk) then
            state_debounce <= next_state_debounce;
        end if;
    end process;

P_REG: process(i_clk, i_rst)
    begin
        if i_rst='1' then
            r_count <= 0;
         elsif rising_edge(i_clk) then
            r_count <= r_count_next;
        end if;
    end process;
P_FSM: process(state_debounce, i_btn, r_count)
    begin
        
        -- default transitions
        next_state_debounce <= state_debounce;
        r_count_next <= r_count;
        
        case state_debounce is
        when state_idle =>
            if i_btn = '1' then
                next_state_debounce <= state_edge;
            end if;
        when state_edge =>
            next_state_debounce <= state_delay;
        when state_delay =>
            if r_count >= (g_delay_count - 1) then
                next_state_debounce <= state_end;
            else
                 r_count_next <= r_count + 1;
            end if;
        when state_end =>
            r_count_next <= 0;
            if i_btn = '1' then
                next_state_debounce <= state_delay;
            else
                next_state_debounce <= state_idle;
            end if;
        when others =>
            -- we should never end up here
            next_state_debounce <= state_idle;
            r_count_next <= 0;
        end case;
    end process;

P_OUT: process(state_debounce, i_btn, r_count)
    begin
        case state_debounce is
        when state_idle =>
            o_btn_db <= '0';
            o_btn_edge <= '0';
        when state_edge =>
            o_btn_db <= '1';
            o_btn_edge <= '1';
        when state_delay =>
            o_btn_db <= '1';
            o_btn_edge <= '0';
        when state_end =>
            o_btn_db <= '1';
            o_btn_edge <= '0';
        when others =>
            -- we should never end up here
            o_btn_db <= '0';
            o_btn_edge <= '0';   
        end case;
    end process;

end Behavioral;
