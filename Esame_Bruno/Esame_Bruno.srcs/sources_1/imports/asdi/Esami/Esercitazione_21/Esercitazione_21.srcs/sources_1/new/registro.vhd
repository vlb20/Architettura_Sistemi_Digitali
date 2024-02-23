library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro is
    generic(
        N : integer := 32
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        write : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        data_out : out std_logic_vector(N-1 downto 0)
        );        
end registro;

architecture Behavioral of registro is
signal stato : std_logic_vector(N-1 downto 0);
begin
data_out <= stato;
reg : process(clk)
begin
    if(rising_edge(clk)) then
        if(rst='1') then
            stato <= (others=>'0');
        elsif(write='1') then
            stato <= data_in;
        end if;
    end if;
end process;

end Behavioral;