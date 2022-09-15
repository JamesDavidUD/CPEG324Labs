----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2022 07:58:28 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( sysclk : in STD_LOGIC;
           btn : in STD_LOGIC;
           sw1 : in STD_LOGIC;
           sw2 : in STD_LOGIC;
           sw3 : in STD_LOGIC;
           sw4 : in STD_LOGIC;
           sw5 : in STD_LOGIC;
           sw6 : in STD_LOGIC;
           sw7 : in STD_LOGIC;
           sw8 : in STD_LOGIC;
           led : out STD_LOGIC;
           led1 : out STD_LOGIC;
           led2 : out STD_LOGIC;
           led3 : out STD_LOGIC;
           led4 : out STD_LOGIC;
           led5 : out STD_LOGIC;
           led6 : out STD_LOGIC;
           led7 : out STD_LOGIC;
           led8 : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is

component calculator is
port
	(
		clk : in std_logic;
		instruction : in std_logic_vector(7 downto 0); --opcode input
		print : out std_logic_vector(7 downto 0) --printing output
	);
end component;

component button_debouncer is
Port ( btn_data : in STD_LOGIC;
           clk : in STD_LOGIC;
           db_data : out STD_LOGIC);
end component;

signal switches : std_logic_vector(7 downto 0);
signal leds : std_logic_vector(7 downto 0);

signal btn_db : std_logic;
signal prev_btn : std_logic := '0';
signal curr_btn : std_logic := '0';

begin

button_debouncer1 : button_debouncer port map (btn_data=>btn, clk=>sysclk, db_data => btn_db);

switches(0) <= sw1;
switches(1) <= sw2;
switches(2) <= sw3;
switches(3) <= sw4;
switches(4) <= not sw5;
switches(5) <= not sw6;
switches(6) <= not sw7;
switches(7) <= not sw8;

led <= btn;



calc : calculator port map (clk => btn_db, instruction => switches, print => leds);

led1 <= leds(0);
led2 <= leds(1);
led3 <= leds(2);
led4 <= leds(3); 

led5 <= leds(4);
led6 <= leds(5);
led7 <= leds(6);
led8 <= leds(7);
     


end Behavioral;
