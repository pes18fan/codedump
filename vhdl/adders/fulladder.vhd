library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           z : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end fulladder;

architecture dataflow of fulladder is
begin
	s <= x xor y xor z;
	c <= (x and y) or (y and z) or (x and z);
end dataflow;

