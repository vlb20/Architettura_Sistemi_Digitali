--MUX INDIRIZZABILE 2:1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entity
entity mux_2_1 is
    port(
        a0 : in std_logic; --2 ingressi
        a1 : in std_logic;
        s : in std_logic; --selezione
        y : out std_logic --uscita
    );
end mux_2_1;

--Architettura livello Dataflow
--qui è come se stessi specificando la tabella di verità della funzione y
architecture dataflow of mux_2_1 is

    begin
        y <= ((a0 AND (NOT s)) OR (a1 AND s)); --assegnazione concorrente
        --tutto ciò che succede a destra -> se ne accorge a sinistra

end dataflow;

--Architettura Dataflow alternativa - When .. else (conditional signal assignment)
architecture alternative of mux_2_1 is

    begin
        y <= a0 when s = '0' else
            a1 when s = '1' else
            '-'; --else incodizionato che tiene conto dei casi non presi in considerazione

end alternative;

--Architettura Dataflow alternativa 2 - With select (selected signal assignment)
architecture alternative2 of mux_2_1 is

    begin
        with s select --s è la variabile che viene valutata
            y <= a0 when '0',
                a1 when '1',
                '-' when others; --in tutti gli altri casi

end alternative2;

--Architettura Behavioral (solitamente usato per circuiti sequenziali)
-- costrutto case
architecture behavioral of mux_2_1 is
    begin
        --Con il process è come se stessi scrivendo una serie di statement sequenziali
        process(a0, a1, s) --sensitivity list -> tutti i segnali la cui variazione attiva il process
            begin
            case s is
            when '0' => y <= a0;
            when '1' => y <= a1;
            when others => y <= '-';
            end case;
        end process;
end behavioral;

--Architettura Behavioral - costrutto if-then-else
architecture behavioral1 of mux_2_1 is
    begin
        process(a0, a1, s)
            begin
                if (s='0') then
                    y <= a0;
                elsif (s='1') then
                    y <= a1;
                else
                    y <= '-';
                end if;
        end process;
end behavioral1;




