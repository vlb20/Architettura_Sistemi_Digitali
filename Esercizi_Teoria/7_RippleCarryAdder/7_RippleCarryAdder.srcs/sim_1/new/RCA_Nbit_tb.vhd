----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2024 18:04:06
-- Design Name: 
-- Module Name: RCA_Nbit_tb - behavioral
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

-- Entità per il test bench (non ha porte in quanto è un'entità di livello superiore per la simulazione)
entity RCA_Nbit_tb is
end RCA_Nbit_tb;

-- Architettura comportamentale per il test bench
architecture behavioral of RCA_Nbit_tb is

    -- Dichiarazione del componente RCA_Nbit, un addizionatore con un parametro generico per la larghezza
    component RCA_Nbit is
        generic (N: natural range 0 to 32 := 8); -- Larghezza predefinita di 8 bit
        port(
            OP_A_RCA : in  std_logic_vector(N-1 downto 0); -- Operando A
            OP_B_RCA : in  std_logic_vector(N-1 downto 0); -- Operando B
            CIN_RCA  : in  std_logic;                      -- Carry in
            S_RCA    : out std_logic_vector(N-1 downto 0); -- Somma in uscita
            COUT_RCA : out std_logic;                      -- Carry out
            OV       : out std_logic                       -- Indicatore di overflow
        );
    end component;
    
    -- Dichiarazione dei segnali per i vettori di test e risultati
    signal OP_A_ext : std_logic_vector(3 downto 0); -- Operando A esteso per addizionatore di 4 bit
    signal OP_B_ext : std_logic_vector(3 downto 0); -- Operando B esteso per addizionatore di 4 bit
    signal CIN_ext  : std_logic;                    -- Carry in esteso
    signal S_ext    : std_logic_vector(3 downto 0); -- Somma in uscita estesa
    signal COUT_ext : std_logic;                    -- Carry out esteso
    signal OV_ext   : std_logic;                    -- Segnale di overflow esteso

begin
    -- Istanza dell'Unità Sotto Test (UUT), l'RCA di 4 bit
    UUT: RCA_Nbit 
        generic map (N => 4) -- Istanziando l'RCA per operandi larghi 4 bit
        port map(
            OP_A_RCA => OP_A_ext,
            OP_B_RCA => OP_B_ext,
            CIN_RCA  => CIN_ext,
            S_RCA    => S_ext,
            COUT_RCA => COUT_ext,
            OV       => OV_ext
        );
    
    -- Blocco del processo per applicare gli stimoli di test
    stim_proc: process
    begin
        wait for 100 ns; -- Ritardo iniziale per la stabilizzazione della simulazione
        
        -- Caso di test 1: Somma di 0 e 7, ci si aspetta 7 senza overflow
        OP_A_ext <= "0000"; -- Operando A è 0
        OP_B_ext <= "0111"; -- Operando B è 7
        CIN_ext  <= '0';    -- Carry-in è 0
        
        wait for 10 ns; -- Attesa per la propagazione del risultato
        
        -- Caso di test 2: Somma di -1 (in complemento a due) e -2, ci si aspetta -3 senza overflow
        OP_A_ext <= "1111"; -- Operando A è -1 (in complemento a due)
        OP_B_ext <= "1110"; -- Operando B è -2 (in complemento a due)
        -- Nota: CIN_ext rimane '0' dall'assegnazione precedente
        
        wait for 10 ns; -- Attesa per la propagazione del risultato
        
        -- Caso di test 3: Somma di 1 e 7, ci si aspetta un overflow poiché 1+7=8 supera l'intervallo di 4 bit
        OP_A_ext <= "0001"; -- Operando A è 1
        OP_B_ext <= "0111"; -- Operando B è 7
        -- CIN_ext rimane ancora '0'
        
        wait for 10 ns; -- Attesa per la propagazione del risultato
        
        -- Caso di test 4: Somma di -1 e -8, ci si aspetta un overflow poiché -1+(-8)=-9 è fuori dall'intervallo di 4 bit
        OP_A_ext <= "1111"; -- Operando A è -1 (in complemento a due)
        OP_B_ext <= "1000"; -- Operando B è -8 (in complemento a due)
        wait for 10 ns; -- Attesa per la propagazione del risultato
        
        -- Caso di test 5: Sottrazione di 3 da 7 (7-3=4), ci si aspetta 4 senza overflow
        -- In complemento a due, la sottrazione è come un'addizione con il secondo numero negativo
        OP_A_ext <= "0111"; -- Operando A è 7
        OP_B_ext <= "1101"; -- Operando B è -3 (in complemento a due)
        CIN_ext  <= '0';    -- Carry-in è 0
        
        wait for 10 ns; -- Attesa per la propagazione del risultato
        
        -- Caso di test 6: Somma di -8 e -3, ci si aspetta -11 che non è rappresentabile, quindi overflow
        OP_A_ext <= "1000"; -- Operando A è -8 (in complemento a due)
        OP_B_ext <= "1101"; -- Operando B è -3 (in complemento a due)
        wait for 10 ns; -- Attesa per la propagazione del risultato
        
        wait; -- Arresta il processo per evitare una simulazione indefinita
    end process;
end behavioral;
