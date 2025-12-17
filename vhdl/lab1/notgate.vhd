-- library things, i forgor

entity notgate is
    port( a: std_logic;
          y: std_logic );
end notgate;

architecture dataflow of notgate is
begin
    y <= not a;
end dataflow;
