library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_8x3_beh is
	port(a: in std_logic_vector (7 downto 0);
		  y: out std_logic_vector (2 downto 0));
end encoder_8x3_beh;

architecture Behavioral of encoder_8x3_beh is
begin
	process (a) is
	begin
		case a is
		when "00000001" =>
			y <= "000";
		when "00000010" =>
			y <= "001";
		when "00000100" =>
			y <= "010";
		when "00001000" =>
			y <= "011";
		when "00010000" =>
			y <= "100";
		when "00100000" =>
			y <= "101";
		when "01000000" =>
			y <= "110";
		when "10000000" =>
			y <= "111";
		when others =>
			y <= "000";
		end case;
	end process;
end Behavioral;

