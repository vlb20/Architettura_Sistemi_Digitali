library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_mod8 is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        count: out std_logic_vector(2 downto 0)
    );
end counter_mod8;

architecture Behavioral of counter_mod8 is

signal temp_c: std_logic_vector(2 downto 0) := (others => '0');

begin

    proc: process(clk)
    
    begin
    
        if rising_edge(clk) then
            if (reset = '1') then
                temp_c <= (others => '0');
            else
              if (enable = '1') then
                temp_c <= std_logic_vector(unsigned(temp_c) + 1);
              end if;
            end if;
        end if;
    end process;
    
    count <= temp_c;
    
end Behavioral;
