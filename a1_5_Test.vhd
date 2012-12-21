--Combination of Instruction Memory, Instruction Decode, Register, and ALU and misc. MUX's and Sign extenders
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity a1_5_Test is
end entity;

architecture behave of a1_5_Test  is

--declaration of the Behaviral Encoder
COMPONENT a1_5 is
	port (aPC: in std_logic_vector(31 downto 0);		--PC Input
		  aPC_OUT: out std_logic_vector(31 downto 0);
		  aF_DATA: out std_logic_vector(31 downto 0);
		  aTEMP_TYPE: out std_logic_vector(1 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TB_aPC: std_logic_vector(31 downto 0);								
							

--Declaration of test signal Outputs
signal TB_aPC_OUT: std_logic_vector(31 downto 0);		--1 bit Read data output
signal TB_aF_DATA: std_logic_vector(31 downto 0);		--32 bit Read data Output
signal TB_aTEMP_TYPE: std_logic_vector(1 downto 0);		--32 bit Read data Output



begin
	uut: a1_5 PORT MAP (
			aPC => TB_aPC,
			aPC_OUT => TB_aPC_OUT, 
			aF_DATA => TB_aF_DATA,
			aTEMP_TYPE => TB_aTEMP_TYPE);
			
			
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
