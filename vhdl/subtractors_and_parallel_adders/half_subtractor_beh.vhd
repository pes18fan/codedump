library IEEE;
use IEEE.std_logic_1164.all;

entity halfsubtractor_beh is
    port ( a : in std_logic;
           b : in std_logic;
           diff : out std_logic;
           borrow : out std_logic);
end halfsubtractor_beh;

architecture behavioral of halfsubtractor_beh is
begin
    process (a, b) is
    begin
        if a = '0' and b = '0' then
            diff <= '0';
            borrow <= '0';
        elsif a = '0' and b = '1' then
            diff <= '1';
            borrow <= '1';
        elsif a = '1' and b = '0' then
            diff <= '1';
            borrow <= '0';
        else
            diff <= '0';
            borrow <= '0';
        end if;
    end process;
end behavioral;
