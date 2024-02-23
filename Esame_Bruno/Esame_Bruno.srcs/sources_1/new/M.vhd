----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 12:50:50
-- Design Name: 
-- Module Name: M - Behavioral
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

entity M is
    port(
        data_in : in std_logic_vector(7 downto 0);
        Res_M: out std_logic;
        count_M : out integer range 0 to 8
    );
end M;

architecture Structural of M is
    component bit_counter is
        port( 
            data_in : in std_logic_vector(7 downto 0);
            count_out : out integer range 0 to 8
        );
    end component;

    component parity_checker is
        port( 
            count_in : in integer range 0 to 8;
            odd_out : out std_logic
        );
    end component;

    signal count : integer range 0 to 8;
    signal odd : std_logic;
begin
    U1: bit_counter port map (data_in, count);
    U2: parity_checker port map (count, odd);

    count_M <= count;
    Res_M <= odd;
    
end Structural;
