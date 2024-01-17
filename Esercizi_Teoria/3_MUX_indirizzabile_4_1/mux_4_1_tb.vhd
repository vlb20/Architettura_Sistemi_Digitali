library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux_4_1_tb is
end mux_4_1_tb;

architecture tb of mux_4_1_tb is
    component mux_4_1
        port(
            b0 : in STD_LOGIC;
            b1 : in STD_LOGIC;
            b2 : in STD_LOGIC;
            b3 : in STD_LOGIC;
            s0 : in STD_LOGIC;
            s1 : in STD_LOGIC;
            y0 : out STD_LOGIC
        );
    end component;

    -- Segnali per simulare gli ingressi, le linee di selezione e l'uscita del MUX 4:1
    signal input   : STD_LOGIC_VECTOR (0 to 3) := (others => 'U');
    signal control : STD_LOGIC_VECTOR (0 to 1) := (others => 'U');
    signal output  : STD_LOGIC := 'U';

begin
    -- Istanza del componente MUX 4:1 da testare
    utt: mux_4_1 port map(
        b0 => input(0),
        b1 => input(1),
        b2 => input(2),
        b3 => input(3),
        s0 => control(0),
        s1 => control(1),
        y0 => output
    );

    -- Processo per generare gli stimoli del testbench
    stim_proc: process
    begin
        -- Inizializzazione dei segnali
        wait for 100 ns;
        input <= "0001"; -- Impostiamo un valore iniziale per gli input
        control <= "00"; -- Impostiamo un valore iniziale per i segnali di selezione
        wait for 10 ns;

        -- Testiamo varie combinazioni di input e segnali di selezione
        control <= "00"; -- Seleziona b0
        wait for 10 ns;
        assert output = input(0)
        report "b0 non selezionato correttamente"
        severity failure;

        control <= "01"; -- Seleziona b1
        wait for 10 ns;
        assert output = input(1)
        report "b1 non selezionato correttamente"
        severity failure;

        control <= "10"; -- Seleziona b2
        wait for 10 ns;
        assert output = input(2)
        report "b2 non selezionato correttamente"
        severity failure;

        control <= "11"; -- Seleziona b3
        wait for 10 ns;
        assert output = input(3)
        report "b3 non selezionato correttamente"
        severity failure;

        -- Termino il processo di stimolazione
        wait;
    end process;
end tb;
