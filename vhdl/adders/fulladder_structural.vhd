library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder_structural is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           z : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end fulladder_structural;

architecture Behavioral of fulladder_structural is
	component halfadder is
		port ( a, b : in std_logic;
				 s, c : out std_logic);
	end component;
	
	signal s1, c1, c2: std_logic;
begin
	u1: halfadder port map(a => x, b => y, s => s1, c => c1);
	u2: halfadder port map(a => s1, b => z, s => s, c => c2);
	
	c <= c1 or c2;
end Behavioral;

