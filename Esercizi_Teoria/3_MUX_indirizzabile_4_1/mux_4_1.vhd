library IEEE;
use IEEE.std_logic_1164.all;

-- Definizione dell'entity per il multiplexer 4:1.
-- Questo componente seleziona uno dei 4 ingressi (b0-b3) in base ai segnali di selezione (s0, s1).
entity mux_4_1 is
    port(
        b0 : in std_logic;
        b1 : in std_logic;
        b2 : in std_logic;
        b3 : in std_logic;
        s0 : in std_logic; --selezione per il primo livello
        s1 : in std_logic; --selezione per il secondo livello
        y0 : out std_logic
    );
end mux_4_1;

--Architettura structural utilizzando la composizione di 3 MUX 2:1

architecture structural of mux_4_1 is
    -- Segnali interni per collegare i due livelli dei multiplexer 2:1
    signal u0 : std_logic := '0';
    signal u1 : std_logic := '0';

    -- Definizione del componente interno mux_2_1.
    -- Questo componente è un multiplexer 2:1 che sarà usato per costruire il multiplexer 4:1.
    component mux_2_1
        port(
            a0 : in std_logic;
            a1 : in std_logic;
            s : in std_logic;
            y : out std_logic
        );
    end component;

    begin
        -- Primo stage di multiplexing: seleziona tra b0 e b1, o tra b2 e b3.
        mux0: mux_2_1
            port map(
                a0 => b0,
                a1 => b1,
                s => s0,
                y => u0
            );

        mux1: mux_2_1
            port map(
                a0 => b2,
                a1 => b3,
                s => s0,
                y => u1
            );

        -- Secondo stage di multiplexing: seleziona tra i risultati del primo stage.
        mux2: mux_2_1
            port map(
                a0 => u0,
                a1 => u1,
                s => s1,
                y => y0
            );
end structural;