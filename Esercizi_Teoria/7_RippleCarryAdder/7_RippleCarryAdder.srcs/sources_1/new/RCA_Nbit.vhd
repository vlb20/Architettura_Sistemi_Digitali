----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vincenzo Luigi Bruno
-- 
-- Create Date: 20.01.2024 17:15:25
-- Design Name: 
-- Module Name: RCA_Nbit - dataflow
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

entity RCA_Nbit is
    -- Generic permette di definire il numero di componenti dell'adder, con un valore di default di 8 bit.
    generic (N: natural range 0 to 32 := 8);
    port(
        --Definizione dei due operandi dell'addizione come vettori di segnali di lunghezza N
        OP_A_RCA: in std_logic_vector(N-1 downto 0);
        OP_B_RCA: in std_logic_vector(N-1 downto 0);
        --Segnale di carry-in per l'operazione di addizione
        CIN_RCA: in std_logic;
        
        --Output dell'addizione, un vettore di segnali della stessa lunghezza degli operandi
        S_RCA: out std_logic_vector(N-1 downto 0);
        --Carry-Out dell'ultimo bit, che può indicare un overflow
        COUT_RCA: out std_logic;
        --Segnale di overflow che indica se l'addizione ha superato la lunghezza N.
        OV: out std_logic
    );
end RCA_Nbit;

architecture dataflow of RCA_Nbit is

    --Definizione del componente FA, che rappresenta un Full Adder.
    component FA is
        port(
            --I port del Full Adder: due operandi e un carry in
            OP_A: in std_logic;
            OP_B: in std_logic;
            CIN: in std_logic;
        
            -- Output del Full Adder: un sum bit e un carry-out.
            S: out std_logic;
            COUT: out std_logic
        );
    end component; 

    --Segnali interni per il carry-out di ogni Full Adder istanziato
    signal cout_int: std_logic_vector(N-1 downto 0);
    --Segnali interni per i risultati intermedi dell'addizione (sum bits)
    signal s_int: std_logic_vector(N-1 downto 0);

begin

    --Generazione di N Full Adders utilizzando il loop generate.
    FA_0_to_N_1: for i in 0 to N-1 generate
    
        --Condizione speciale per il primo Full Adder, che utilizza il carry-in dell'intero addizionatore
        IF_CLAUSE: if i=0 generate
        
            FA_0: FA port map(
                --Mappatura dei port del Full Adder con i segnali appropriati.
                OP_A => OP_A_RCA(0),
                OP_B => OP_B_RCA(0),
                CIN => CIN_RCA,
                S => s_int(0),
                COUT => cout_int(0)
            );
        end generate IF_CLAUSE;
        
        --Condizione per tutti gli altri Full Adders che non sono il primo
        ELSE_CLAUSE: if i/=0 generate
        
            FA_comp: FA port map(
                OP_A => OP_A_RCA(i),
                OP_B => OP_B_RCA(i),
                --il carry-in è il carry-out del Full Adder precedente
                CIN => cout_int(i-1),
                --il carry_out va al prossimo Full Adder
                COUT => cout_int(i),
                --il sum bit è parte del risultato finale dell'addizione
                S => s_int(i)
            );
         end generate ELSE_CLAUSE;
         
     end generate FA_0_to_N_1;
     
     --Assegnazione del risultato finale dell'addizione al port di outoput S_RCA
     S_RCA <= s_int;
     --Assegnazione del carry-out finale al port di output COUT_RCA
     COUT_RCA <= cout_int(N-1);
     
     --Calcolo del segnale di overflow basato sui bit più significativi degli operandi e del risultato
     OV <= (OP_A_RCA(N-1) and OP_B_RCA(N-1) and not s_int(N-1)) or (not OP_A_RCA(N-1) and not OP_B_RCA(N-1) and s_int(N-1));

end dataflow;
