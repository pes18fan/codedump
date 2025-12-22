library IEEE;
use IEEE.std_logic_1164.all;

entity orgate is
    port( a, b: std_logic;
          y: std_logic );
end orgate;

architecture dataflow of orgate is
begin
    y <= a or b;
end dataflow;
