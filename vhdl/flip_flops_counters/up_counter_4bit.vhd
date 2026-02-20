library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity up_counter_4bit is
	port(clk, clr: in std_logic;
		  cnt: out std_logic_vector (3 downto 0));
end up_counter_4bit;

architecture Behavioral of up_counter_4bit is
	signal temp: std_logic_vector (3 downto 0);
begin
	process (clk, clr) is
	begin
		if clr = '1' then
			temp <= "0000";
		elsif clk 'event and clk = '1' then
			temp <= temp + 1;
		end if;
	end process;

	cnt <= temp;
end Behavioral;

