library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binary_parallel_adder is
	port ( a, b : in std_logic_vector (3 downto 0);
	       cin  : in std_logic;
		   s    : out std_logic_vector (3 downto 0);
		   cout : out std_logic);
end binary_parallel_adder;

-- note: the assumption is that a fulladder.vhd exists in the same directory
architecture structural of binary_parallel_adder is
	component fulladder is
		port ( x, y, z: in std_logic;
			   s, c: out std_logic);
	end component;
	
	signal c0, c1, c2: std_logic;
begin
	fa0: fulladder port map(x => a(0), y => b(0), z => cin, s => s(0), c => c0);
	fa1: fulladder port map(x => a(1), y => b(1), z => c0, s => s(1), c => c1);
	fa2: fulladder port map(x => a(2), y => b(2), z => c1, s => s(2), c => c2);
	fa3: fulladder port map(x => a(3), y => b(3), z => c2, s => s(3), c => cout);
end structural;

