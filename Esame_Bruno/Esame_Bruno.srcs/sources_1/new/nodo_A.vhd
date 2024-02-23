----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 12:50:50
-- Design Name: 
-- Module Name: nodo_A - Structural
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

entity nodo_A is
    port(
        reset: in std_logic;
        start: in std_logic;
        clk_A: in std_logic;
        ack: in std_logic;
        req: out std_logic;
        data_out: out std_logic_vector(7 downto 0)
    );
end nodo_A;

architecture Structural of nodo_A is

    signal read_temp: std_logic;
    signal en_count_temp: std_logic;
    signal rst_count_temp: std_logic;
    signal addr_temp: std_logic_vector(2 downto 0);

begin

    unita_controllo: entity work.CU_A port map(
        clk_A => clk_A,
        start => start,
        reset => reset,
        ack => ack,
        count => addr_temp,
        req => req,
        en_count => en_count_temp,
        read => read_temp,
        rst_count => rst_count_temp
    );
    
    counter: entity work.counter_mod8 port map(
        clk => clk_A,
        reset => rst_count_temp,
        enable => en_count_temp,
        count => addr_temp
    );
    
    ROM: entity work.rom port map(
        clk => clk_A,
        read => read_temp,
        addr => addr_temp,
        data_out => data_out
    );


end Structural;
