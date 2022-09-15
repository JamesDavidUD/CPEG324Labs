library ieee;
use ieee.std_logic_1164.all;

entity reg4 is
	port (  
		clk, enable : in std_logic;
		d : in std_logic_vector (3 downto 0);
		q : out std_logic_vector (3 downto 0) := "0000" --Initializes Output to 0000
	);
end entity reg4;

architecture behave of reg4 is
begin
reg4_process: process (clk, enable, d)
	begin
		if rising_edge(clk) then
			if enable = '1' then 
				q <= d;
			end if;
		end if;
	end process reg4_process;
end architecture behave;