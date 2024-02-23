----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 13:51:34
-- Design Name: 
-- Module Name: bit_counter - Behavioral
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

entity bit_counter is
    port(
        data_in : in std_logic_vector(7 downto 0);
        count_out : out integer range 0 to 8
    );
end bit_counter;

architecture Behavioral of bit_counter is

begin
    process(data_in)
        variable temp_count : integer range 0 to 8;
    begin
        temp_count := 0;
        for i in data_in'range loop
            if data_in(i) = '1' then
                temp_count := temp_count + 1;
            end if;
        end loop;
        count_out <= temp_count;
    end process;

end Behavioral;
