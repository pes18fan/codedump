library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfadder_structural is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end halfadder_structural;

-- NOTE: This assumes that a xor_gate.vhd and and_gate.vhd file are present in 
-- the same directory
architecture structural of halfadder_structural is
	component xor_gate is
		port ( x, y : in std_logic;
				 z : out std_logic);
	end component;
	
	component and_gate is
		port ( x, y : in std_logic;
				 z : out std_logic);
	end component;
begin
	u1: xor_gate port map(x => x, y => y, z => s);
	u2: and_gate port map(x => x, y => y, z => c);
end structural;

