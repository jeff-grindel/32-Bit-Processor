--Combination of Instruction Memory and Instruction Decode
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity a1_3_Test is
end entity;

architecture behave of a1_3_Test  is

--declaration of the Behaviral Encoder
COMPONENT a1_3 is
	port (aPC: in std_logic_vector(31 downto 0);
		  aRD1: out std_logic_vector(31 downto 0); 		--32-bit output1
		  aRD2: out std_logic_vector(31 downto 0); 		--32-bit output2
		  aCTRL_OUT: out std_logic_vector(5 downto 0));	--Control Output to pass through the control values for alu operation
end COMPONENT;

--Declaration of test signal Inputs
signal TB_aPC: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal TB_aRD1: std_logic_vector(31 downto 0);		--32 bit Read data output
signal TB_aRD2: std_logic_vector(31 downto 0);		--32 bit Read data Output
signal TB_aCTRL_OUT: std_logic_vector(5 downto 0);	--5-bit Function Code


begin
	uut: a1_3 PORT MAP (
			aPC => TB_aPC,
			aRD1 => TB_aRD1, 
			aRD2 => TB_aRD2, 
			aCTRL_OUT => TB_aCTRL_OUT);
			
			
	PC_GEN: process
	begin 
		TB_aPC <= x"00000500" after 0 ns,	--lw
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
