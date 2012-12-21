--Takes a 5-bit number and sign extends it to a 32-bit number
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Sign_Extend_5_Test is
end entity;

architecture behavior of Sign_Extend_5_Test is

COMPONENT Sign_Extend_5 is
	port (INPUT: in std_logic_vector(4 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TB_INPUT: std_logic_vector(4 downto 0);

--Declaration of test signal Outputs
signal TB_OUTPUT: std_logic_vector(31 downto 0);

begin

	uut: Sign_Extend_5 PORT MAP (
			INPUT => TB_INPUT,
			OUTPUT => TB_OUTPUT);

	INPUT_GEN: process
	begin
		TB_INPUT <= "01110" after 0 ns,
				    "01000" after 10 ns;
		wait;
	end process INPUT_GEN;
end architecture behavior;

		