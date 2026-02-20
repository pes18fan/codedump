library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jkff_beh is
	port(j, k, clk, clr: in std_logic;
		  q, q0: out std_logic);
end jkff_beh;

architecture Behavioral of jkff_beh is
begin
	process (clk, clr) is
		variable tmp: std_logic;
	begin
		if clk 'event and clk = '1' then
			if j = '0' and k = '0' then
				tmp := tmp;
			elsif j = '1' and k = '1' then
				tmp := not tmp;
			elsif j = '0' and k = '1' then
				tmp := '0';
			else
				tmp := '1';
			end if;
		elsif clr = '1' then
			tmp := '0';
		end if;
		
		q <= tmp;
		q0 <= not tmp;
	end process;
end Behavioral;

