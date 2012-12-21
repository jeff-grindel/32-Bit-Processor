--Instruction Memory:
--Input: Program Counter
--Output: Instruction
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Instruction_Memory_Test is
end entity;

architecture behave of Instruction_Memory_Test is

--declaration of the Behaviral Encoder
COMPONENT Instruction_Memory is
  	  port (PC: in std_logic_vector(31 downto 0); 	--32-bit instruction
	        INSTRUCTION: out std_logic_vector(31 downto 0)); --32-bit instruction(hardcoded in)
end COMPONENT;

--Declaration of test signal Inputs
signal TB_PC: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal TB_INSTRUCTION: std_logic_vector(31 downto 0);		--5-bit output to go to Rs

begin
	uut: Instruction_Memory PORT MAP (
			PC => TB_PC,
			INSTRUCTION => TB_INSTRUCTION);
			
	PC_GEN: process
	begin 
		TB_PC <= x"00000500" after 0 ns,	--lw
				 x"00000504" after 10 ns,	--sw
				 x"00000508" after 20 ns,	--add
				 x"0000050C" after 30 ns,	--or
				 x"00000510" after 40 ns,	--slt
				 x"00000514" after 50 ns,	--beq
				 x"00000518" after 60 ns,	--j
				 x"0000051C" after 70 ns,	--bne
				 x"00000520" after 80 ns,	--ori
				 x"00000524" after 90 ns,	--srl
				 x"00000528" after 100 ns,	--lui
				 x"00000530" after 110 ns; 	--EMPTY
	wait;
	end process PC_GEN;
end architecture behave;	


		
