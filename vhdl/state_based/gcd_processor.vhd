library ieee;
use ieee.std_logic_1164.all;

entity gcd is
    port(x_i, y_i: in unsigned(3 downto 0)
         clk, clr: in std_logic;
         go_i: in std_logic;
         d: out unsigned(3 downto 0));
end gcd;

architecture beh of gcd is
    type state is (idle, init, check, update_x, update_y, get);
    signal ps: state := idle;
    signal ns: state;

begin
    -- clock pulse
    process (clk, clr) is
    begin
        if clr = '1' then
            ps <= idle;
        elsif clk 'event and clk = '1' then
            ps <= ns;
        end if;
    end process;

    process (ps, x_i, y_i) is
        variable x, y: unsigned(3 downto 0)

    begin
        case ps is
        when idle =>
            if go_i = '0' then
                ns <= idle;
            else
                ns <= init;
            end if;
        when init =>
            x := x_i;
            y := y_i;
        when check =>
            if x < y then
                ns <= update_y;
            elsif x > y then
                ns <= update_x
            else
                ns <= get;
            end if;
        when update_x =>
            x := x - y;
            ns <= check;
        when update_y =>
            y := y - x;
            ns <= check;
        when get =>
            d <= x;
            ns <= idle;
        end case;
    end process;
end beh;
