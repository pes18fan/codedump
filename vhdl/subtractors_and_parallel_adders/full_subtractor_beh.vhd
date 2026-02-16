library IEEE;
use IEEE.std_logic_1164.all;

entity fullsubtractor_beh is
    port(xyb: in std_logic_vector (2 downto 0);
         db: out std_logic_vector (1 downto 0));
end fullsubtractor_beh;

architecture dataflow of fullsubtractor_beh is
begin
    process (xyb) is
    begin
        case xyb is
        when "000" | "101" | "110" =>
            db <= "00";
        when "011" =>
            db <= "01";
        when "100" =>
            db <= "10";
        when others =>
            db <= "11";
        end case;
    end process;
end dataflow;
