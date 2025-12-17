-- library things, i forgor

entity andgate is
    port( a, b: std_logic;
          y: std_logic );
end andgate;

architecture dataflow of andgate is
begin
    y <= a and b;
end dataflow;
