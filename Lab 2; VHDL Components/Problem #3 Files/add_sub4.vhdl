library ieee;
use ieee.std_logic_1164.all;

entity add_sub4 is
	port
	(
		addorsub : in std_logic; --decides if the operation being executed is addition or subtraction
		a : in std_logic_vector(3 downto 0); --4 bit input 1
		b : in std_logic_vector(3 downto 0); --4 bit input 2
		result : out std_logic_vector(3 downto 0); --4 bit result
		carry_out : out std_logic; --carry bit output, 0 if no carry out, 1 if there is
		overflow : out std_logic; --overflow bit, 0 if no overflow, 1 if there is
		underflow : out std_logic --underflow bit, 0 if no underflow, 1 if there is
	);
end add_sub4;

architecture behave of add_sub4 is
--since the 4 bit adder/subtractor circuit has 4 full adders, we add full_adder.vhdl as a component and use 4 of them for the logic
component full_adder is
	port
	(
		a : in std_logic; --input 1
		b : in std_logic; --input 2
		carry_in : in std_logic; --input carry
		sum : out std_logic; --sum of a and b
		carry_out : out std_logic --output carry
	);
end component;

signal b_twos: std_logic_vector(3 downto 0); --contains two's complement of input 2 (b) if subtraction operation is selected, if addition is selected, b is not changed
signal carry: std_logic_vector(4 downto 0); --contains the carrys used

begin
 
	carry(0) <= addorsub; --If the operation is subtraction, this represents the +1 needed for coversion to two's complement
	carry_out <= carry(4); --Holds the last bit of the carry for the output carry bit
	overflow <= not(carry(4)) and carry(3); --Checks if overflow has occured, overflow has only occured when the last two carry bits are 0 and 1, so and is used
	underflow <= carry(4) and not(carry(3)); --Checks if underflow has occured, overflow has only occured when the last two carry bits are 1 and 0, so and 

	--this section flips all bits in the second input if the subtraction operation is selected, using xor
	b_twos(0) <= b(0) xor addorsub; 
	b_twos(1) <= b(1) xor addorsub;
	b_twos(2) <= b(2) xor addorsub; 
	b_twos(3) <= b(3) xor addorsub;

	full_adder1: full_adder port map(carry_in=>carry(0),a=>a(0),b=>b_twos(0),sum=>result(0),carry_out=>carry(1));
	full_adder2: full_adder port map(carry_in=>carry(1),a=>a(1),b=>b_twos(1),sum=>result(1),carry_out=>carry(2));
	full_adder3: full_adder port map(carry_in=>carry(2),a=>a(2),b=>b_twos(2),sum=>result(2),carry_out=>carry(3));
	full_adder4: full_adder port map(carry_in=>carry(3),a=>a(3),b=>b_twos(3),sum=>result(3),carry_out=>carry(4)); 

end behave;
