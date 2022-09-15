library ieee;
use ieee.std_logic_1164.all;

entity gen_mux is
	generic(N:integer);
	port
	(
		In0,In1,In2,In3: in std_logic_vector(N-1 downto 0);
		Sel: in std_logic_vector(1 downto 0);
		Z: out std_logic_vector(N-1 downto 0)
	);
end gen_mux;

architecture behave of gen_mux is
begin
	with Sel select
		Z <= In0 when "00",
			 In1 when "01",
			 In2 when "10",
			 In3 when "11",
			 In3 when others;
end architecture behave; 