--MUX FOR 2-input 5-bit Information
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Mux_2 is
	port (ZERO: in std_logic_vector(4 downto 0);
		  ONE: in std_logic_vector(4 downto 0);
		  CTRL: in std_logic_vector(1 downto 0);
		  OUTPUT: out std_logic_vector(4 downto 0));
end entity Mux_2;

architecture behavior of Mux_2 is
begin
	OUTPUT <= ZERO when CTRL = "10" else	--I-TYPE, Outputs Rt
			  ONE when CTRL = "00" else		--R-TYPE, Outputs Rd
			  "11111";
end architecture behavior;

		