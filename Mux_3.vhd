--MUX for 3 input 32 bit numbers
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Mux_3 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Mux_3;

architecture behavior of Mux_3 is
begin
	OUTPUT <= TWO when CTRL = "000010" else		--Shift Ammount 
			  ONE when CTRL = "001111" else		--Load Upper Imm
			  ZERO;								--Else Zero(RD1(Rs Data)
end architecture behavior;

		