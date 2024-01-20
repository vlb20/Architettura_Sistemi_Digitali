----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vincenzo Luigi Bruno
-- 
-- Create Date: 20.01.2024 17:15:25
-- Design Name: 
-- Module Name: FA - dataflow
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


entity FA is
    port(
        OP_A: in std_logic; -- Primo operando del Full Adder (bit)
        OP_B: in std_logic; -- Secondo operando del Full Adder (bit)
        CIN: in std_logic;  -- Carry-In, il riporto da un'eventuale addizione precedente
        
        S: out std_logic; -- Sum bit, il risultato dell'addizione dei due operandi e del Carry-In
        COUT: out std_logic -- Carry-Out, il riporto risultante dall'addizione dei due operandi e del Carry-In
    );
end FA;

architecture dataflow of FA is

begin
    -- Assegna al port di uscita S il risultato dell'operazione XOR tra gli operandi e il Carry-In.
    -- Questo è il valore del bit di somma per l'addizione binaria.
    S <= (OP_A xor OP_B) xor CIN;
    -- Assegna al port di uscita COUT il risultato dell'operazione OR tra:
    -- 1. L'AND degli operandi, che genera un carry se entrambi gli operandi sono 1.
    -- 2. L'AND tra il Carry-In e l'OR degli operandi, che genera un carry se uno degli operandi e il Carry-In sono 1.
    -- Questo è il valore del Carry-Out per l'addizione binaria.
    COUT <= (OP_A and OP_B) or (CIN and (OP_A or OP_B));

end dataflow;
