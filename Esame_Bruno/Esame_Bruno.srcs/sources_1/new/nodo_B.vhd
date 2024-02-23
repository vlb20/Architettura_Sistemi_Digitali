----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 12:50:50
-- Design Name: 
-- Module Name: nodo_B - Structural
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
use IEEE.NUMERIC_STD.ALL;

entity nodo_B is
    port(
        reset: in std_logic;
        clk_B: in std_logic;
        req: in std_logic;
        data_in: in std_logic_vector(7 downto 0);
        ack: out std_logic
    );
end nodo_B;

architecture Structural of nodo_B is

    signal load_temp: std_logic;
    signal reg_temp: std_logic_vector(7 downto 0);
    signal en_count_temp: std_logic;
    signal write_temp: std_logic;
    signal addr_temp: std_logic_vector(2 downto 0);
    signal countM_temp: integer range 0 to 8;
    signal resM_temp: std_logic;
    signal countM_vector: std_logic_vector(2 downto 0);

begin

    countM_vector <= std_logic_vector(to_unsigned(countM_temp, countM_vector'length));

    unita_controllo: entity work.CU_B port map(
        clk_B => clk_B,
        req => req,
        Res_M => resM_temp,
        load => load_temp,
        write => write_temp,
        en_count => en_count_temp,
        ack => ack
    );
    
    reg: entity work.registro 
    generic map(8)
    port map(
        clk => clk_B,
        rst => reset,
        write => load_temp,
        data_in => data_in,
        data_out => reg_temp
    );
    
    macchina: entity work.M port map(
        data_in => reg_temp,
        Res_M => resM_temp,
        count_M => countM_temp
    );
    
    count: entity work.counter_mod8 port map(
        clk => clk_B,
        reset => reset,
        enable => en_count_temp,
        count => addr_temp
    );
    
    MEM: entity work.mem port map(
        clk => clk_B,
        reset => reset,
        input => reg_temp & countM_vector,
        write_addr => addr_temp,
        read_addr => addr_temp,
        write_en => write_temp
    );


end Structural;
