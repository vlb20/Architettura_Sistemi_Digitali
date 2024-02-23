library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity rom is
    port(
        clk: in std_logic;
        read: in std_logic;
        addr: in std_logic_vector(2 downto 0);
        data_out: out std_logic_vector(7 downto 0)
    );
    
end rom;

architecture Behavioral of rom is

type rom_type is array (0 to 7) of std_logic_vector(7 downto 0);
signal ROM: rom_type := (
    X"00", 
    X"11", 
    X"23", 
    X"35", 
    X"45",
    X"55",
    X"66", 
    X"77"
);

begin

    process(clk)
        begin
            if rising_edge(clk) then
                if read = '1' then
                    data_out <= ROM(conv_integer(addr));
                end if;
            end if;
    end process;

end Behavioral;
