-- library things, i forgor

entity andgate is
    port( a, b: std_logic;
          y: std_logic );
end andgate;

architecture behavioral of andgate is
begin
    process (a, b) is
    begin
        if a = '1' and b = '1' then
            y <= '1';
        else
            y <= '0';
        end if;
    end process;
end behavioral;
