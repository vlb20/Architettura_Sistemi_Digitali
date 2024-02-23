----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vincenzo Luigi Bruno
-- 
-- Create Date: 19.02.2024 12:50:50
-- Design Name: 
-- Module Name: CU_B - microrom
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
use IEEE.std_logic_arith.ALL;

entity CU_B is
    port(
        clk_B: in std_logic;
        req: in std_logic;
        Res_M: in std_logic;
        load: out std_logic;
        write: out std_logic;
        en_count: out std_logic;
        ack: out std_logic
    );
end CU_B;

architecture microrom of CU_B is

component MicroROM is
    port(
        PC: in unsigned(1 downto 0);
        PC_next: out unsigned(1 downto 0);
        JRes_M: out std_logic;
        write: out std_logic;
        load: out std_logic;
        ack: out std_logic;
        en_count: out std_logic
    );
end component;

signal PC_next, PC: unsigned(1 downto 0);
signal JRes_M: std_logic;

begin

    mROM: MicroRom
    port map(
        PC => PC,
        PC_next => PC_next,
        JRes_M => JRes_M,
        write => write,
        load => load,
        ack => ack,
        en_count => en_count
    );

    reg_PC: process(clk_B)
    begin
        if rising_edge(clk_B) then
            if (req = '1') then
                PC <= "01";
            elsif (JRes_M = '0') then
                PC <= PC_next;
            else
                if (Res_M = '0') then
                    PC <= "00";
                else
                    PC <= PC_next;
                end if;
            end if;
        end if;
    end process reg_PC;

end microrom;
