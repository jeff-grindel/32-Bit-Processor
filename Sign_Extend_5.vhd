--Takes a 5-bit number and sign extends it to a 32-bit number
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Sign_Extend_5 is
	port (INPUT: in std_logic_vector(4 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Sign_Extend_5;

architecture behavior of Sign_Extend_5 is
begin
	OUTPUT(31 downto 8) <= x"000000";
	OUTPUT(7 downto 5) <= "000";
	OUTPUT(4 downto 0) <= INPUT;
end architecture behavior;

		