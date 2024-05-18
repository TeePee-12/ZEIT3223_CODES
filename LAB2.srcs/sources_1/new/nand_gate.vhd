----------------------------------------------------------------------------------
-- ZEIT3223 Embedded Systems Lab Work
-- z5349517 Thomas Phelan
-- UNSW Canberra
-- Module Name: nand_gate - Behavioral
-- Create Date: 24.07.2023 16:19:45
--
-- This is a NAND gate for use when the 'nand' operator is unsuitable
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           X : out STD_LOGIC);
end nand_gate;

architecture Behavioral of nand_gate is
begin
X <= not(A and B);
end Behavioral;