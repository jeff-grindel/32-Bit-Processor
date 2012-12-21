--Takes a 16-bit number and sign extends it to a 32-bit number
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Sign_Extend_16 is
	port (INPUT: in std_logic_vector(15 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Sign_Extend_16;

architecture behavior of Sign_Extend_16 is
begin
	OUTPUT(31 downto 16) <= x"0000";
	OUTPUT(15 downto 0) <= INPUT;
end architecture behavior;

		