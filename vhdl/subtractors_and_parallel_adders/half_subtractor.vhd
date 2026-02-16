library IEEE;
use IEEE.std_logic_1164.all;

entity halfsubtractor is
    port ( a : in std_logic;
           b : in std_logic;
           diff : out std_logic;
           borrow : out std_logic);
end halfsubtractor;

architecture dataflow of halfsubtractor is
begin
    diff <= a xor b;
    borrow <= (not a) and b;
end dataflow;
