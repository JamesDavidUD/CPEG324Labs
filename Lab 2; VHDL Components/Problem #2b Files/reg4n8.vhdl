library ieee;
use ieee.std_logic_1164.all;

entity reg4n8 is
	port (  
		clk, enable : in std_logic;
		sel : in std_logic_vector(2 downto 0);	
		d : in std_logic_vector (3 downto 0);
		q : out std_logic_vector (3 downto 0)
	);
end entity reg4n8;

architecture structural of reg4n8 is
 
component reg4 is
	port (  
		clk, enable : in std_logic;
		d : in std_logic_vector (3 downto 0);
		q : out std_logic_vector (3 downto 0)
	);
end component;

component demux_1to8 is
	port
	(
		enable: in std_logic;
		sel: in std_logic_vector(2 downto 0);
		output_enable: out std_logic_vector(7 downto 0)
	);
end component; 

component mux_8to1
	port
	(
		input_vector: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(2 downto 0);
		o: out std_logic_vector(3 downto 0)
	);
end component;

signal enable_vector : std_logic_vector(7 downto 0) := (others => '0');
signal output_vector : std_logic_vector(31 downto 0):= (others => '0');
signal output_final : std_logic_vector(3 downto 0):= (others => '0');

begin
	
	demux : demux_1to8 port map (enable => enable, sel => sel, 00);
	mux : mux_8to1 port map (input_vector => output_vector, sel => sel, o => output_final);

	reg_1: reg4 port map (d => d, clk => clk, enable => enable_vector(0), q => output_vector(3 downto 0));
	reg_2: reg4 port map (d => d, clk => clk, enable => enable_vector(1), q => output_vector(7 downto 4));
	reg_3: reg4 port map (d => d, clk => clk, enable => enable_vector(2), q => output_vector(11 downto 8));
	reg_4: reg4 port map (d => d, clk => clk, enable => enable_vector(3), q => output_vector(15 downto 12));
	reg_5: reg4 port map (d => d, clk => clk, enable => enable_vector(4), q => output_vector(19 downto 16));
	reg_6: reg4 port map (d => d, clk => clk, enable => enable_vector(5), q => output_vector(23 downto 20));
	reg_7: reg4 port map (d => d, clk => clk, enable => enable_vector(6), q => output_vector(27 downto 24));
	reg_8: reg4 port map (d => d, clk => clk, enable => enable_vector(7), q => output_vector(31 downto 28));
	
	q <= output_final;
	
end architecture structural;