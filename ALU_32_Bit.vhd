--32-Bit ALU Takes 2 32-bit inputs(A and B) and determines what needs to 
--be done by the control signals. Outputs the respective output
--and also a branch signal 1: to branch, 0: no branch
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_32_Bit is
   port (A_DATA: in std_logic_vector(31 downto 0);
		 B_DATA: in std_logic_vector(31 downto 0);
		 CONTROL: in std_logic_vector(5 downto 0);
		 BRANCH: out std_logic; 					--1 To Branch, 0: No branch
		 F_DATA: out std_logic_vector(31 downto 0));
		 
end entity ALU_32_Bit;

architecture behave of ALU_32_Bit is 
begin 
	F_DATA <= std_logic_vector(unsigned(A_DATA) + unsigned(B_DATA)) when (CONTROL = "100011" OR CONTROL ="101011" or CONTROL = "100000") else --LW, SW, ADD
			  A_DATA OR B_DATA when (CONTROL = "100101" OR CONTROL = "001101") else --OR, ORI
			  x"00000001" when (CONTROL = "101010" AND (A_DATA < B_DATA)) else --SLT A<B
			  x"00000000" when (CONTROL = "101010" AND (A_DATA > B_DATA)) else --SLT A>B
			  B_DATA when ((CONTROL = "000100" OR CONTROL = "000101") AND (A_DATA = B_DATA)) else --BEQ
			  B_DATA when ((CONTROL = "000100" OR CONTROL = "000101") AND (A_DATA /= B_DATA)) else --BNE
			  std_logic_vector(unsigned(B_DATA) srl to_integer(unsigned(A_DATA))) when CONTROL = "000010" else --SRL
			  std_logic_vector(unsigned(B_DATA) or (unsigned(A_DATA) sll 16)) when CONTROL = "001111" else		--Imm in A: B: RT
			  x"FFFFFFFF";
	
	
	BRANCH <= '1' when (CONTROL = "000100" AND (A_DATA = B_DATA)) else		--BEQ
			  '1' when (CONTROL = "000101" AND (A_DATA /= B_DATA)) else	    --BNE
			  '0';
end architecture behave;
