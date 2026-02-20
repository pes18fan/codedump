library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_2x4_beh is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           y : out std_logic_vector (3 downto 0));
end decoder_2x4_beh;

architecture Behavioral of decoder_2x4_beh is
begin
	process (a, b) is
	begin
		if a = '0' and b = '0' then
			y <= "0001";
		elsif a = '0' and b = '1' then
			y <= "0010";
		elsif a = '1' and b = '0' then
			y <= "0100";
		else
			y <= "1000";
		end if;
	end process;
end Behavioral;

