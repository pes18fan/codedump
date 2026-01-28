library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfadder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end halfadder;

architecture dataflow of halfadder is
begin
	s <= a xor b;
	c <= a and b;
end dataflow;
