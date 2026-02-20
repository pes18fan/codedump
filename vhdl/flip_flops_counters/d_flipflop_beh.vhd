library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_beh is
	port(d, clk, clr: in std_logic;
		  q, q0: out std_logic);
end dff_beh;

architecture Behavioral of dff_beh is
begin
	process (clk, clr) is
	begin
		if clr = '1' then
			q <= '0';
			q0 <= '1';
		elsif clk 'event and clk = '1' then
			q <= d;
			q <= not d;
		end if;
	end process;
end Behavioral;

