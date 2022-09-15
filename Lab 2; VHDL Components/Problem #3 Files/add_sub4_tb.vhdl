library ieee;
use ieee.std_logic_1164.all;

entity add_sub4_tb is
end add_sub4_tb;

architecture behave of add_sub4_tb is
--  Declaration of the component that will be instantiated.
component add_sub4
	port (  
			addorsub : in std_logic;
			a : in std_logic_vector(3 downto 0);
			b : in std_logic_vector(3 downto 0);
			result : out std_logic_vector(3 downto 0);
			carry_out : out std_logic;
			overflow : out std_logic;
			underflow : out std_logic
		); 
end component;

signal addorsub : std_logic;
signal a : std_logic_vector(3 downto 0);
signal b : std_logic_vector(3 downto 0);
signal result : std_logic_vector(3 downto 0);
signal carry_out : std_logic;
signal overflow : std_logic;
signal underflow: std_logic;

begin

	addsub4: add_sub4 port map (addorsub => addorsub, a => a, b => b, result => result, carry_out => carry_out, overflow => overflow, underflow => underflow);
	
process
	type pattern_type is record
	--  The inputs of the reg.
	addorsub : std_logic;
	a : std_logic_vector(3 downto 0);
	b : std_logic_vector(3 downto 0);
	--  The expected outputs of the reg.
	result : std_logic_vector(3 downto 0);
	carry_out : std_logic;
	overflow : std_logic;
	underflow : std_logic;
end record; 

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := 
(('0', "0000", "0000", "0000", '0', '0','0'), --testing nothing
('0', "0001", "0001", "0010", '0', '0', '0'), --1 + 1 = 2
('1', "0001", "0001", "0000", '1', '0', '0'), --1 - 1 = 0, no overflow but there is a carry 
('0', "0010", "1100", "1110", '0', '0', '0'), --+2 + -4 = -2, no overflow or carry
('0', "1101", "1110", "1011", '1', '0', '0'), -- -3 + -2 = -5, no overflow, but there is a carry
('1', "0100", "0010", "0010", '1', '0', '0'), -- 4 - 2 = 2, no overflow but there is a carry 
('0', "0111", "0110", "1101", '0', '1', '0'), -- 7 + 6 = 13, but overflow occurs so the result is -3
('0', "1001", "1010", "0011", '1', '0', '1'), -- -7 + -6 = -13, but underflowflow occurs so the result is 3 
('1', "0001", "1111", "0010", '1', '0', '0') -- 1 - (-1) = 2
); --end of test vectors

begin 
	--  Check each pattern.
	for n in patterns'range loop
		--  Set the inputs.
		addorsub <= patterns(n).addorsub;
		a <= patterns(n).a;
		b <= patterns(n).b;
		--  Wait for the results.
		wait for 5 ns;
		--  Check the outputs.
		assert result = patterns(n).result
		report "incorrect result" severity error;
		
		assert carry_out = patterns(n).carry_out
		report "incorrect carry_out" severity error;
		
		assert overflow = patterns(n).overflow
		report "incorrect overflow" severity error;
		
		assert underflow = patterns(n).underflow
		report "incorrect underflow" severity error;
		
	end loop;
	assert false report "end of test" severity note;
	--  Wait forever; this will finish the simulation.
	wait;
	end process;
end behave;