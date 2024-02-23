----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vincenzo Luigi Bruno
-- 
-- Create Date: 19.02.2024 12:50:50
-- Design Name: 
-- Module Name: MicroRom - synth
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

entity MicroRom is
    port(
        PC: in unsigned(1 downto 0);
        PC_next: out unsigned(1 downto 0);
        JRes_M: out std_logic;
        write: out std_logic;
        load: out std_logic;
        ack: out std_logic;
        en_count: out std_logic
    );
end MicroRom;

architecture synth of MicroRom is
    
    type Controllo_type is record --struttura delle microistruzioni
        PC_next:  unsigned(1 downto 0);
        JRes_M:   std_logic;
        write:    std_logic;
        load:     std_logic;
        en_count: std_logic;
        ack:      std_logic;
    end record;
    
    CONSTANT idle: Controllo_type := (
            PC_next => "00",
            JRes_M => '0',
            write => '0',
            load => '0',
            en_count => '0',
            ack => '0'
    );
    CONSTANT q1: Controllo_type := (
            PC_next => "10",
            JRes_M => '0',
            write => '0',
            load => '1',
            en_count => '0',
            ack => '1'
    );
    CONSTANT q2: Controllo_type := (
            PC_next => "11",
            JRes_M => '1',
            write => '0',
            load => '0',
            en_count => '0',
            ack => '1'
    );
    CONSTANT q3: Controllo_type := (
            PC_next => "00",
            JRes_M => '0',
            write => '1',
            load => '0',
            en_count => '1',
            ack => '1'
    );
    
    type ROM_TYPE is array(0 to 3) of Controllo_type;
    CONSTANT ROM: ROM_type := ( --Contiene le 4 microistrizioni (corrispondono agli stati)
        0 => idle,
        1 => q1,
        2 => q2,
        3 => q3
    );
    
    signal Controllo: Controllo_type;

begin

    Controllo <= ROM(conv_integer(PC));
    
        PC_next <= Controllo.PC_next;
        JRes_M <= Controllo.JRes_M;
        write <= Controllo.write;
        load <= Controllo.load;
        en_count <= Controllo.en_count;
        ack <= Controllo.ack;

end synth;
