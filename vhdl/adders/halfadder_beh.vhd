library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfadder_beh is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end halfadder_beh;

architecture Behavioral of halfadder_beh is
begin
	process (a, b) is
	begin
		s <= a xor b;
		c <= a and b;
	end process;
end Behavioral;

