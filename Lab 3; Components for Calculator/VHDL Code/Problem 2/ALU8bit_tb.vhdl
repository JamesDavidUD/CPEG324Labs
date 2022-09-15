library ieee;
use ieee.std_logic_1164.all;

entity ALU8bit_tb is
end ALU8bit_tb;

architecture behave of ALU8bit_tb is
--  Declaration of the component that will be instantiated.
component ALU8bit
	port
	(
		opcode : in std_logic_vector(1 downto 0); --decides which operation the ALU will execute
		a : in std_logic_vector(7 downto 0); --8 bit input 1
		b : in std_logic_vector(7 downto 0); --8 bit input 2
		result : out std_logic_vector(7 downto 0); --8 bit result
		equal : out std_logic
	);
end component;

signal opcode : std_logic_vector(1 downto 0);
signal a : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);
signal result : std_logic_vector(7 downto 0);
signal equal : std_logic;

begin

	ALU8bit1: ALU8bit port map (opcode => opcode, a => a, b => b, result => result, equal => equal);
	
process
	type pattern_type is record
	--  The inputs of the reg.
	opcode : std_logic_vector(1 downto 0);
	a : std_logic_vector(7 downto 0);
	b : std_logic_vector(7 downto 0);
	--  The expected outputs of the reg.
	result : std_logic_vector(7 downto 0);
	equal : std_logic; 
end record; 

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := 
(
("00", "00000000", "00000000", "00000000", '0'), --testing nothing
("00", "00000001", "00000001", "00000010", '0'), --1 + 1 = 2
("01", "00000011", "00000010", "00000001", '0'), --3 - 2 = 1
("10", "00000111", "00000001", "00000111", '0'), --7 (nothing) 1 = 7
("11", "00000111", "00000111", "00000111", '1'), --7 = 7
("11", "00000111", "00000110", "00000111", '0') --6 =/= 7 

); --end of test vectors

begin 
	--  Check each pattern.
	for n in patterns'range loop
		--  Set the inputs.
		opcode <= patterns(n).opcode;
		a <= patterns(n).a;
		b <= patterns(n).b;
		--  Wait for the results.
		wait for 5 ns;
		--  Check the outputs.
		assert result = patterns(n).result
		report "incorrect result" severity error;
		
		assert equal = patterns(n).equal
		report "incorrect equal" severity error;
		
	end loop;
	assert false report "end of test" severity note;
	--  Wait forever; this will finish the simulation.
	wait;
	end process;
end behave;