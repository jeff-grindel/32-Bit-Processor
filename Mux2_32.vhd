--MUX FOR 2-input 32-bit Information
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Mux2_32 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		 CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Mux2_32;

architecture behavior of Mux2_32 is
begin
	OUTPUT <= ONE when (CTRL = "100011" or CTRL = "101011" or CTRL = "001101") else		--I-TYPE, Outputs IMM
			  ZERO;
end architecture behavior;

		