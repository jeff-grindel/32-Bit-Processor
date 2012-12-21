--PC_CALC: takes in the PC value and control siganls
--to determine if the instruction needs to jump, branch, or just
--return PC+4
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_Calc is
   port (PC_IN: in std_logic_vector(31 downto 0);   --32-bit PC
		IMM: in std_logic_vector(31 downto 0);		--32-bit Immidiate value
		Branch: in std_logic;						--Branch Control Signal from ALU
		Control: in std_logic_vector(5 downto 0);	--Control signal from Instruction Mem
		X_Type: in std_logic_vector(1 downto 0); 	--Type of instruction: Going to be used for Jump Instruction "01"
		PC_OUT: out std_logic_vector(31 downto 0)); --32-bit PC output
end entity PC_Calc;

architecture behave of PC_Calc is 

begin 
	
	PC_OUT <= std_logic_vector((unsigned(IMM) sll 2) + unsigned(PC_IN)) when (Branch = '1' and (Control = "000100" or Control = "000101")) else	--For branch
			  std_logic_vector(unsigned(IMM) sll 2) when (X_Type = "01") else	
			  std_logic_vector(unsigned(PC_IN) + 4); --Default case of adding 4 
			  
end architecture behave;
