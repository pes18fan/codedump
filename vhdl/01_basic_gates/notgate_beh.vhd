-- library things, i forgor

entity notgate is
    port( a: std_logic;
          y: std_logic );
end notgate;

architecture behavioral of notgate is
begin
    process (a) is
    begin
        if a = '1' then
            y <= '0';
        else
            y <= '1';
        end if;
    end process;
end behavioral;
