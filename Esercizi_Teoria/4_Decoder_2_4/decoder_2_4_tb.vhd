library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity decoder_2_4_tb is
end decoder_2_4_tb;

architecture decoder_2_4 of decoder_2_4_tb is

	component decoder_2_4
		port( a: IN STD_LOGIC_VECTOR(1 downto 0);
					y: OUT STD_LOGIC_VECTOR(3 downto 0)
		);
	end component;

--Input
signal input : STD_LOGIC_VECTOR(1 downto 0) := (others => 'U');
--Output
signal output : STD_LOGIC_VECTOR(3 downto 0);

BEGIN
	--Instanziamo l'Unit Under Test
	uut: entity work.decoder_2_4(behavioral) port map(
		a => input,
		y => output
	);

	--Stimulus process
	stim_proc: process
	begin

	wait for 100 ns;

	input <= "00";

	wait for 100 ns;

	input <= "01";

	wait for 100 ns;

	input <= "10";

	wait for 100 ns;

	input <= "11";

    wait for 100 ns;
	wait;
	end process;

end;