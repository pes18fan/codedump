library IEEE;
use IEEE.std_logic_1164.all;

entity fullsubtractor is
    port(x: in std_logic;
         y: in std_logic;
         bin: in std_logic;
         d: out std_logic;
         bout: out std_logic);
end fullsubtractor;

architecture dataflow of fullsubtractor is
begin
    d <= x xor y xor bin;
    bout <= ((not x) and y) or ((not x) and bin) or (y and bin);
end dataflow;
