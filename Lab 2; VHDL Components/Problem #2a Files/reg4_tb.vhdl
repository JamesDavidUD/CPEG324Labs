library ieee;
use ieee.std_logic_1164.all;

entity reg4_tb is
end reg4_tb;

architecture behave of reg4_tb is
--  Declaration of the component that will be instantiated.
component reg4
	port (  
			clk, enable : in std_logic;
			d : in std_logic_vector (3 downto 0);
			q : out std_logic_vector (3 downto 0)
		);
end component;

signal d, q : std_logic_vector(3 downto 0); 
signal clk, enable : std_logic;

begin
reg_0: reg4 port map (d => d, clk => clk, enable => enable, q => q);

process
	type pattern_type is record
	--  The inputs of the reg.
	d: std_logic_vector (3 downto 0);
	clock, enable: std_logic;
	--  The expected outputs of the reg.
	q: std_logic_vector (3 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := 
(("0001", '0', '0', "0000"), --D starts as 1, clock is 0, enable is 0, and Q has no value written to it, so the default value of 0 is kept
("0001", '1', '1', "0001"), --Simulates Rising Edge along with enable being on, D is now written to Q
("0011", '0', '1', "0001"), -- D is changed to 3, but since there is no rising edge, Q does not change
("0011", '1', '1', "0011"), --Simulated rising edge, D is now written to Q
("0111", '0', '0', "0011"), --D is changed to 7, but with no rising edge or enable bit Q does not change
("0111", '1', '0', "0011")); --Simulated rising edge, but since the enable bit is not 1, D is not written to Q

begin 
	--  Check each pattern.
	for n in patterns'range loop
		--  Set the inputs.
		d <= patterns(n).d;
		clk <= patterns(n).clock;
		enable <= patterns(n).enable;
		--  Wait for the results.
		wait for 1 ns;
		--  Check the outputs.
		assert q = patterns(n).q
		report "bad output value" severity error;
	
	assert false report "end of test" severity note;
	--  Wait forever; this will finish the simulation.
	wait;
	end process;
end behave;

