library ieee;
use ieee.std_logic_1164.all;

entity demux_1to8 is
	port
	(
		enable: in std_logic;
		sel: in std_logic_vector(2 downto 0);
		output_enable: out std_logic_vector(7 downto 0) := (others => '0')
	);
end demux_1to8;

architecture behave of demux_1to8 is
begin
	process(sel, enable)
	begin
	output_enable <= "00000000";
		case sel is
			when "000" => output_enable(0) <= enable;
			when "001" => output_enable(1) <= enable;
			when "010" => output_enable(2) <= enable;
			when "011" => output_enable(3) <= enable;
			when "100" => output_enable(4) <= enable;
			when "101" => output_enable(5) <= enable;
			when "110" => output_enable(6) <= enable;
			when others => output_enable(7) <= enable;
		end case;
end process;
end architecture behave;