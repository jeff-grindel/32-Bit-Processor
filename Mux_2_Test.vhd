--MUX FOR 2-input 5-bit Information
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Mux_2_Test is
end entity;

architecture behavior of Mux_2_Test is

COMPONENT Mux_2 is
	port (ZERO: in std_logic_vector(4 downto 0);
		  ONE: in std_logic_vector(4 downto 0);
		  CTRL: in std_logic_vector(1 downto 0);
		  OUTPUT: out std_logic_vector(4 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TB_ZERO: std_logic_vector(4 downto 0);
signal TB_ONE: std_logic_vector(4 downto 0);
signal TB_CTRL: std_logic_vector(1 downto 0);

--Declaration of test signal Outputs
signal TB_OUTPUT: std_logic_vector(4 downto 0);

begin

	uut: Mux_2 PORT MAP (
			ZERO => TB_ZERO,
			ONE => TB_ONE,
			CTRL => TB_CTRL,
			OUTPUT => TB_OUTPUT);

	ZERO_GEN: process
	begin
		TB_ZERO <= "10101" after 0 ns,
				   "11111" after 20 ns;
		wait;
	end process ZERO_GEN;
	
	ONE_GEN: process
	begin
		TB_ONE <= "00001" after 0 ns,
				  "11111" after 20 ns;
		wait;
	end process ONE_GEN;
	
	CTRL_GEN: process
	begin
		TB_CTRL <= "00" after 0 ns,
			       "01" after 5 ns,
				   "00" after 10 ns,
				   "01" after 15 ns,
				   "11" after 20 ns;
		wait;
	end process CTRL_GEN;
end architecture behavior;

		