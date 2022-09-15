library ieee;
use ieee.std_logic_1164.all;

entity reg8n4_tb is
end reg8n4_tb;

architecture behave of reg8n4_tb is
--  Declaration of the component that will be instantiated.
component reg8n4 is 
	port (  
		clk, we : in std_logic;
		rs1, rs2 : in std_logic_vector(1 downto 0);	
		ws : in std_logic_vector (1 downto 0);
		wd : in std_logic_vector(7 downto 0);
		rd1,rd2 : out std_logic_vector (7 downto 0)
	);
end component;

signal clk, we : std_logic;
signal rs1, rs2 : std_logic_vector(1 downto 0);
signal ws : std_logic_vector (1 downto 0);
signal wd : std_logic_vector(7 downto 0);
signal rd1,rd2 : std_logic_vector (7 downto 0);

begin

reg84 : reg8n4 port map (clk => clk, we => we, rs1 => rs1, rs2 => rs2, ws => ws, wd => wd, rd1 => rd1, rd2 => rd2);

process
	type pattern_type is record
	--  The inputs of the reg.
	clk, we : std_logic;
	rs1, rs2 : std_logic_vector(1 downto 0);
	ws : std_logic_vector (1 downto 0);
	wd : std_logic_vector(7 downto 0);
	--  The expected outputs of the reg.
	rd1,rd2 : std_logic_vector (7 downto 0); 
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := 
(('0','1',"00","00","00","00000000","00000000","00000000"), --Start
('1','0',"00","01","00","00000001","00000001","00000000"), --Write 1 to Register 1, Reading Register 1 and 2
('0','1',"00","01","01","00000011","00000001","00000000"), --Blank, Reading Register 1 and 2
('1','0',"00","01","01","00000010","00000001","00000010"), --Write 2 to Register 2, Reading Register 1 and 2
('0','1',"01","10","10","00000011","00000010","00000000"), --Blank
('1','0',"01","10","10","00000011","00000010","00000011"), --Write 3 to Register 3, Reading Register 2 and 3
('0','1',"10","11","11","00000100","00000011","00000000"), --Blank
('1','0',"10","11","11","00000100","00000011","00000100"), --Write 4 to Register 4, Reading Register 3 and 4
('0','0',"00","01","00","00000000","00000001","00000010"), --Reading Register 1 and 2
('0','0',"10","11","00","00000000","00000011","00000100") --Reading Register 3 and 4
);


begin
		--  Check each pattern.
	for n in patterns'range loop
		--  Set the inputs.
		clk <= patterns(n).clk;
		we <= patterns(n).we;
		rs1 <= patterns(n).rs1;
		rs2 <= patterns(n).rs2;
		ws <= patterns(n).ws;
		wd <= patterns(n).wd;
		--  Wait for the results.
		wait for 5 ns;
		--  Check the outputs.
		assert rd1 = patterns(n).rd1
		report "bad rd1" severity error;
		assert rd2 = patterns(n).rd2
		report "bad rd2" severity error;

	end loop;
	assert false report "end of test" severity note;
	--  Wait forever; this will finish the simulation.
	wait;
	end process;
end behave;