----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 14:16:51
-- Design Name: 
-- Module Name: Handshaking_TB - Behavioral
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

entity handshaking_tb is
end handshaking_tb;

architecture Behavioral of handshaking_tb is

    component nodo_A
        port(
            reset: in std_logic;
            start: in std_logic;
            clk_A: in std_logic;
            ack: in std_logic;
            req: out std_logic;
            data_out: out std_logic_vector(7 downto 0)
        );
    end component;
    
    component nodo_B
        port(
            reset: in std_logic;
            clk_B: in std_logic;
            req: in std_logic;
            data_in: in std_logic_vector(7 downto 0);
            ack: out std_logic
        );
    end component;
    
    signal clk_a: std_logic := '0';
    signal clk_b: std_logic := '0';
    signal reset: std_logic := '0';
    signal tmp_start: std_logic := '0';
    signal tmp_ack: std_logic := '0';
    signal tmp_req: std_logic := '0';
    signal tmp_data : std_logic_vector(7 downto 0) := (others => '0');
    constant CLK_periodA : time := 10ns;
    constant CLK_periodB: time := 40ns;

begin

    clk_a_proc: process
    begin
        clk_a <= '0';
        wait for CLK_periodA/2;
        clk_a <= '1';
        wait for CLK_periodA/2;
    end process;
    
    clk_b_proc: process
    begin
        clk_b <= '0';
        wait for CLK_periodB/2;
        clk_b <= '1';
        wait for CLK_periodB/2;
    end process;
    
    nodoA: nodo_A port map(
        reset,
        tmp_start,
        clk_a,
        tmp_ack,
        tmp_req,
        tmp_data
    );
    
    nodoB: nodo_B port map(
        reset,
        clk_b,
        tmp_req,
        tmp_data,
        tmp_ack
    );
    
    test_proc: process
    begin
        wait for 100ns;
        
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        tmp_start <= '1';
        wait for 10ns;
        tmp_start <= '0';
        wait;
    end process;

    


end Behavioral;
