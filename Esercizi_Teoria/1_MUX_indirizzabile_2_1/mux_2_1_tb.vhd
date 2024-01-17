library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux_2_1_tb is
end mux_2_1_tb;

architecture mux2_1 of mux_2_1_tb is

	component mux_2_1
		port(	a0 : in STD_LOGIC;
				a1 : in STD_LOGIC;
				s :  in STD_LOGIC;
				y : out STD_LOGIC
		);
	end component;

    --Creo segnali per simulare gli ingressi(input), la linea di selezione(controle) e l'uscita(output) del multiplexer
    --Inizialmente impostati a 'U' che sta per "uninitialized"
	signal input 	: STD_LOGIC_VECTOR (0 to 1) := (others => 'U');
	signal control 	: STD_LOGIC 				:= 'U';
	signal output 	: STD_LOGIC 				:= 'U';

	begin
		-- specifico l'implementazione dell'entity che voglio simulare:
		utt : entity work.mux_2_1(dataflow) port map(
            --collego i segnali di test ai rispettivi porti del componente
			a0 => input(0),
			a1 => input(1),
			s => control,
			y => output
		);

        --Processo che simula gli stimoli di ingresso e di controllo del MUX
		stim_proc : process
		begin

		wait for 100 ns; --attendo 100 ns

        --imposto il vettore di input a '01'
		input 	<= "01"; -- visto che control='U' l'uscita rimarrà ancora 'U'
		wait for 10 ns;

        --cambio control a '1' che seleziona l'ingresso a1
		control <= '1';   -- in uscita va a1='1'

		wait for 5 ns;
		input 	<= "00"; -- in uscita va ancora a1, che stavolta è '0'

		wait for 5 ns;
		input 	<= "10"; -- in uscita va ancora a1='0'

		wait for 5 ns;
		control <= '0';   -- in uscita va a0='1'

        --controlla se l'uscita è 0 altrimenti messaggio di errore
		assert output = '0'
		report "errore0"
		severity failure;


		wait;
		end process;

end;
