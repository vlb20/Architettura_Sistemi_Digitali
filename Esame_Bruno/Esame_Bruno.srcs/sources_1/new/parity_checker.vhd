----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 13:51:34
-- Design Name: 
-- Module Name: parity_checker - Behavioral
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

entity parity_checker is
    Port ( count_in : in integer range 0 to 8;
           odd_out : out std_logic);
end parity_checker;

architecture Behavioral of parity_checker is
begin
    process(count_in)
    begin
        if count_in mod 2 = 1 then
            odd_out <= '1';  -- output = 1 se è dispari
        else
            odd_out <= '0';  -- output = 1 se è pari
        end if;
    end process;
end Behavioral;
