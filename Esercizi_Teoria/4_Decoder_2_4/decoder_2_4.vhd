library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Definizione dell'entity per il decoder 2:4.
entity decoder_2_4 is
	port(
			a : in STD_LOGIC_VECTOR(1 downto 0); -- Ingresso di dimensione 2 (da 1 a 0)
			y : out STD_LOGIC_VECTOR(3 downto 0) -- Uscita di dimensione 4 (da 3 a 0)
	);
end decoder_2_4;

-- Architettura comportamentale utilizzando un process.
architecture behavioral of decoder_2_4 is
	begin
		process(a) -- Il process reagisce ai cambiamenti di 'a'.
			begin
				case a is -- Assegnazione dell'uscita basata sul valore di 'a'.
					when "00" => y <= "0001"; -- y3 è alto
					when "01" => y <= "0010"; -- y2 è alto
					when "10" => y <= "0100"; -- y1 è alto
					when "11" => y <= "1000"; -- y0 è alto
					when others => y <= "----"; -- Uscita non definita
				end case;
			end process;
end behavioral;

-- Architettura dataflow usando assegnazioni concorrenti.
architecture dataflow of decoder_2_4 is
	begin
		y(3) <= a(1) and a(0); -- Uscita y3 attiva se a è "11".
		y(2) <= a(1) and not a(0); -- Uscita y2 attiva se a è "10".
		y(1) <= not a(1) and a(0); -- Uscita y1 attiva se a è "01".
		y(0) <= not a(1) and not a(0); -- Uscita y0 attiva se a è "00".
end dataflow;

-- Seconda versione di dataflow utilizzando espressioni 'when-else'.
architecture dataflow_v1 of decoder_2_4 is
	begin
		y <= "0001" when a="00" else -- Condizioni simili all'architettura comportamentale.
			 "0010" when a="01" else
			 "0100" when a="10" else
			 "1000" when a="11" else
			 "----"; -- Uscita non definita
end dataflow_v1;

-- Terza versione di dataflow usando la costruzione 'with-select'.
architecture dataflow_v2 of decoder_2_4 is
	begin
		with a select -- Una sintassi alternativa per le condizioni.
			y <=
				"0001" when "00",
				"0010" when "01",
				"0100" when "10",
				"1000" when "11",
				"----" when others; -- Uscita non definita
end dataflow_v2;
