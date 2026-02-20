library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_2x4 is
    Port ( a, b : in std_logic;
           y : out std_logic_vector (3 downto 0));
end decoder_2x4;

architecture dataflow of decoder_2x4 is
begin
	y(0) <= (not a) and (not b);
	y(1) <= (not a) and b;
	y(2) <= a and (not b);
	y(3) <= a and b;
end dataflow;

