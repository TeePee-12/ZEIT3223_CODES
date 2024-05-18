--------------------------------------------------
-- Timer code template for ZEIT3223 lab assignment 2
-- Written by Edwin Peters, 2023
--------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity counter is
  Generic (
    G_MAX_COUNT : integer := 1000; -- Overflow the timer at this count -1
    G_OUTPUT_WIDTH: integer := 32 -- Recommended to leave at 32 bit                                  
    );
  Port ( 
    i_clk, i_rst : in std_logic; 
    i_clear_ovf_flag : in std_logic; -- input flag that allows us to clear the
    -- overflow flag
    o_count: out std_logic_vector(G_OUTPUT_WIDTH-1 downto 0);
    o_ovf : out std_logic -- Set high when the timer overflows
    );
end counter;

-- Insert your counter code here. Increase on an i_clk rising edge
-- Reset the counter and output flag when i_rst is high
-- Set o_ovf to 1 when the counter reaches G_MAX_COUNT-1 and set o_ovf to 0
-- when i_clear_flag = 1
architecture Behavioral of counter is
    signal r_count : integer range 0 to G_MAX_COUNT := 0;
    signal r_ovf, r_ovf_next, r_set_flag : std_logic := '0';
begin

    o_ovf <= r_ovf;
    o_count <= std_logic_vector(r_ovf & std_logic_vector(to_unsigned(r_count, o_count'length-1)));

  process(i_clk, i_rst)

  begin
    if i_rst = '1' then
        r_count <= 0;
        r_ovf <= '0';
    
   elsif rising_edge(i_clk) then
       if r_count = G_MAX_COUNT - 1 then
           r_count <= 0;
           r_ovf <= '1';
       else
           r_count <= r_count +1;
       end if;
  end if;
  
  if i_clear_ovf_flag = '1' then
      r_ovf <= '0';
  
  end if;   
  end process;
  

end Behavioral;       
