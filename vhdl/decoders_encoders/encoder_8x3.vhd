library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_8x3 is
	port(a: in std_logic_vector (7 downto 0);
		  y: out std_logic_vector (2 downto 0));
end encoder_8x3;

architecture dataflow of encoder_8x3 is
begin
	y(0) <= a(1) or a(3) or a(5) or a(7);
	y(1) <= a(2) or a(3) or a(6) or a(7);
	y(2) <= a(4) or a(5) or a(6) or a(7);
end dataflow;

