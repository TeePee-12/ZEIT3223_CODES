library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

architecture sim of counter_tb is
  -- Constants
  constant CLOCK_PERIOD : time :=  0.5ns;-- Adjust this value as needed

  -- Signals for connecting to the timer module
  signal i_clk_tb           : std_logic := '0';
  signal i_rst_tb           : std_logic := '0';
  signal i_clear_ovf_flag_tb: std_logic := '0';
  signal o_count_tb         : std_logic_vector(31 downto 0);
  signal o_ovf_tb           : std_logic;

begin

  -- Instantiate the timer module
  uut: entity work.counter
    generic map (
      G_MAX_COUNT     => 1000,  -- Set the desired maximum count
      G_OUTPUT_WIDTH  => 32     -- Leave it at 32 bits as recommended
    )
    port map (
      i_clk            => i_clk_tb,
      i_rst            => i_rst_tb,
      i_clear_ovf_flag => i_clear_ovf_flag_tb,
      o_count          => o_count_tb,
      o_ovf            => o_ovf_tb
    );

  -- Clock process
    i_clk_tb <= not i_clk_tb after CLOCK_PERIOD;
    
  -- Stimulus process
  process
  begin
    -- Initialize/reset the timer
    i_rst_tb <= '1';
    i_clear_ovf_flag_tb <= '0';
    wait for 20 ns; -- Hold reset for a while
    i_rst_tb <= '0';

    -- Generate some clock cycles
    wait for 1100 ns;

    -- Set i_clear_ovf_flag_tb to clear overflow flag
   

    -- Continue for some more cycles
    
    i_clear_ovf_flag_tb <= '1';
    wait for 10 ns;
    i_clear_ovf_flag_tb <= '0';
    
    wait for 300 ns;

    -- You can add more test scenarios as needed

    -- Finish the simulation
    wait;
  end process;

end sim;
