library IEEE;
use IEEE.std_logic_1164.all;

entity orgate is
    port( a, b: std_logic;
          y: std_logic );
end orgate;

architecture behavioral of orgate is
begin
    process (a, b) is
    begin
        if a = '1' or b = '1' then
            y <= '1';
        else
            y <= '0';
        end if;
    end process;
end behavioral;
