--MUX for 3 input 32 bit numbers
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Mux_3_Test is
end entity;

architecture behavior of Mux_3_Test is

COMPONENT Mux_3 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TB_ZERO: std_logic_vector(31 downto 0);
signal TB_ONE: std_logic_vector(31 downto 0);
signal TB_TWO: std_logic_vector(31 downto 0);
signal TB_CTRL: std_logic_vector(5 downto 0);

--Declaration of test signal Outputs
signal TB_OUTPUT: std_logic_vector(31 downto 0);

begin

	uut: Mux_3 PORT MAP (
			ZERO => TB_ZERO,
			ONE => TB_ONE,
			TWO => TB_TWO,
			CTRL => TB_CTRL,
			OUTPUT => TB_OUTPUT);

	ZERO_GEN: process
	begin
		TB_ZERO <= x"40000000" after 0 ns,
				   x"FFFFFFFF" after 30 ns;
		wait;
	end process ZERO_GEN;
	
	ONE_GEN: process
	begin
		TB_ONE <= x"80000000" after 0 ns,
				  x"FFFFFFFF" after 30 ns;
		wait;
	end process ONE_GEN;
	
	TWO_GEN: process
	begin
		TB_TWO <= x"A0000000" after 0 ns,
				  x"FFFFFFFF" after 30 ns;
		wait;
	end process TWO_GEN;
	
	CTRL_GEN: process
	begin
		TB_CTRL <= "000010" after 0 ns,
			       "001111" after 5 ns,
				   "010101" after 10 ns;
		wait;
	end process CTRL_GEN;
end architecture behavior;

		