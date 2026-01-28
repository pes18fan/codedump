library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder_beh is
    Port ( xyz : in  STD_LOGIC_VECTOR (2 downto 0);
           cs  : out  STD_LOGIC_VECTOR (1 downto 0));
end fulladder_beh;

architecture Behavioral of fulladder_beh is
begin
	process (xyz) is
	begin
		case xyz is
			when "000" =>
				cs <= "00";
			when "001" | "010" | "100" =>
				cs <= "01";
			when "011" | "101" | "110" =>
				cs <= "10";
			when others =>
				cs <= "11";
		end case;
	end process;
end Behavioral;
