--MUX FOR 2-input 32-bit Information for data mem or alu out
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Mux2_32_1 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		 CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Mux2_32_1;

architecture behavior of Mux2_32_1 is
begin
	OUTPUT <= ZERO when (CTRL = "100011") else		--Just reads from data for 
			  ONE;
end architecture behavior;

		