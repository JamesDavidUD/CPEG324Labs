library ieee;
use ieee.std_logic_1164.all;

entity gen_mux_tb is
	generic(N : integer := 4);
end gen_mux_tb;

architecture test of gen_mux_tb is
	component gen_mux
		generic(N:integer);
		port
		(
			In0,In1,In2,In3: in std_logic_vector(N-1 downto 0);
			Sel: in std_logic_vector(1 downto 0);
			Z: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	--All Inputs
	signal In0 : std_logic_vector(N-1 downto 0);
	signal In1 : std_logic_vector(N-1 downto 0);
	signal In2 : std_logic_vector(N-1 downto 0); 
	signal In3 : std_logic_vector(N-1 downto 0);
	signal Sel : std_logic_vector(1 downto 0);
	--The Output
	signal Z : std_logic_vector(N-1 downto 0);
begin  
	multiplexer: gen_mux
		generic map (N=>4)
		port map (In0 => In0, In1 => In1, In2 => In2, In3 => In3, Sel => Sel, Z => Z);
	
	process begin
		In0 <= "1100";
		In1 <= "0110";
		In2 <= "0011";
		In3 <= "0001";
		
		Sel <= "00";
		wait for 5 ns;
		
		Sel <= "01";
		wait for 5 ns;
		
		Sel <= "10";
		wait for 5 ns;
		
		Sel <= "11";
		wait for 5 ns;
		
		assert false report "end of test";
		wait;
	end process;
end;
		
		
		
		