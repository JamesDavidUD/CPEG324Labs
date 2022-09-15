library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is
	port
	(
		input_vector: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(2 downto 0);
		o: out std_logic_vector(3 downto 0)
	);
end mux_8to1;

architecture behave of mux_8to1 is
begin 
	with sel select
		o <= input_vector(3 downto 0) when "000",
			 input_vector(7 downto 4) when "001",
			 input_vector(11 downto 8) when "010",
			 input_vector(15 downto 12) when "011",
			 input_vector(19 downto 16) when "100",
			 input_vector(23 downto 20) when "101",
			 input_vector(27 downto 24) when "110",
			 input_vector(31 downto 28) when "111",
			 input_vector(3 downto 0) when others;
end architecture behave;