library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq is
    port(x, clk, clr: in std_logic;
         y: out std_logic);
end seq;

architecture beh of seq is
    type state is (a, b, c, d);
    signal pr_st: state := a
    signal nx_st: state;

begin
    -- clock pulse
    process (clk, clr) is
    begin
        if clr = '1'
            pr_st <= a;
        elsif clk 'event and clk = '1' then
            pr_st <= nx_st;
        end if;
    end process;

    process (pr_st, x) is
    begin
        case pr_st is
        when a =>
            if x = '0' then
                nx_st <= a;
                y <= '0';
            else
                nx_st <= b;
                y <= '0';
            end if;
        when b =>
            if x = '0' then
                nx_st <= a;
                y <= '0';
            else
                nx_st <= c;
                y <= '0';
            end if;
        when c =>
            if x = '0' then
                nx_st <= d;
                y <= '0';
            else
                nx_st <= c;
                y <= '0';
            end if;
        when d =>
            if x = '0' then
                nx_st <= a;
                y <= '0';
            else
                nx_st <= b;
                y <= '1';
            end if;
        end case;
    end process;
end beh;
