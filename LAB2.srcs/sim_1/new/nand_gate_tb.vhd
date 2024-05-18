----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2023 16:28:08
-- Design Name: 
-- Module Name: nand_gate_tb - Behavioral
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

entity nand_gate_tb is
end nand_gate_tb;

architecture Behavioral of nand_gate_tb is
    signal A, B, X: std_logic;
    component nand_gate is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           X : out STD_LOGIC);
    end component;
    
begin

C_NAND: nand_gate port map (X=>X, A=>A, B=>B);

process
begin
wait for 3 ns;
A <= '0';
B <= '0';
wait for 3 ns;
A <= '1';
B <= '0';
wait for 3 ns;
A <= '0';
B <= '0';
wait for 3 ns;
A <= '0';
B <= '1';
wait for 3 ns;
A <= '0';
B <= '0';
wait for 3 ns;
A <= '1';
B <= '1';
wait for 3 ns;
A <= '0';
B <= '0';
end process;

end Behavioral;
