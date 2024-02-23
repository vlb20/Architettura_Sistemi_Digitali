----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vincenzo Luigi Bruno
-- 
-- Create Date: 19.02.2024 12:50:50
-- Design Name: 
-- Module Name: CU_A - Behavioral
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

entity CU_A is
    port(
        clk_A: in std_logic;
        start: in std_logic;
        reset: in std_logic;
        ack: in std_logic;
        count: in std_logic_vector(2 downto 0);
        req: out std_logic;
        en_count: out std_logic;
        read: out std_logic;
        rst_count: out std_logic
    );
end CU_A;

architecture Behavioral of CU_A is

type stato is (idle, q1, q2, q3, q4);
signal curr_state: stato := idle;
signal next_state: stato := idle;

begin

    stato_uscita: process(curr_state, start, ack)
    begin
    
    rst_count <= '0';
    read <= '0';
    en_count <= '0';
    req <= '0';
    
    case curr_state is
        when idle =>
            if (start = '1') then
                rst_count <= '1';
                next_state <= q1;
            else
                next_state <= idle;
            end if;
        when q1 =>
            read <= '1';
            next_state <= q2;
        when q2 => 
            req <= '1';
            if(ack = '1') then
                next_state <= q3;
            else
                next_state <= q2;
            end if;
        when q3 =>
            if (ack = '0') then
                next_state <= q4;
            else
                next_state <= q3;
            end if;
        when q4 => 
            en_count <= '1';
            if (count = "111") then
                next_state <= idle;
            else
                next_state <= q1;
            end if;
    end case;
    end process;
    
    mem: process(clk_A)
    begin
        if rising_edge(clk_A) then
            if reset = '1' then
                curr_state <= idle;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;

end Behavioral;
