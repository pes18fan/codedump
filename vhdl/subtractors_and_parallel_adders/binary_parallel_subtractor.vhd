library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binary_parallel_subtractor is
	port ( x, y : in std_logic_vector (3 downto 0);
	       bin  : in std_logic;
		   d    : out std_logic_vector (3 downto 0);
		   bout : out std_logic);
end binary_parallel_subtractor;

architecture Behavioral of binary_parallel_subtractor is
	component fullsubtractor is
		Port ( x    : in  STD_LOGIC;
			   y    : in  STD_LOGIC;
               bin  : in  STD_LOGIC;
               d    : out  STD_LOGIC;
               bout : out  STD_LOGIC);
	end component;
	
	signal b0, b1, b2: std_logic;
begin
	fa0: fullsubtractor port map(x => x(0), y => y(0), bin => bin, d => d(0), bout => b0);
	fa1: fullsubtractor port map(x => x(1), y => y(1), bin => b0, d => d(1), bout => b1);
	fa2: fullsubtractor port map(x => x(2), y => y(2), bin => b1, d => d(2), bout => b2);
	fa3: fullsubtractor port map(x => x(3), y => y(3), bin => b2, d => d(3), bout => bout);
end Behavioral;

