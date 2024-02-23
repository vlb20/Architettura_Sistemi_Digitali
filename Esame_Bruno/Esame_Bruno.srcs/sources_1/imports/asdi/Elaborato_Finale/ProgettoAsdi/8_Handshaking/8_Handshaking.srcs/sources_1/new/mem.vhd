library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity mem is
    port(
        clk: in std_logic;
        reset: in std_logic;
        input: in std_logic_vector(10 downto 0);
        write_addr: in std_logic_vector(2 downto 0);
        read_addr: in std_logic_vector(2 downto 0);
        write_en: in std_logic;
        output: out std_logic_vector(10 downto 0)
    );
end mem;

architecture Behavioral of mem is

type mem_type is array(0 to 7) of std_logic_vector(10 downto 0);
signal MEM: mem_type := (others => "00000000000");

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if write_en = '1' then
                MEM(conv_integer(write_addr)) <= input;
            end if;
            output <= MEM(conv_integer(read_addr));
        end if;
    end process;

end Behavioral;
