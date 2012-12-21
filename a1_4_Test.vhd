--Combination of Instruction Memory, Instruction Decode, Register, and ALU and misc. MUX's and Sign extenders
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity a1_4_Test is
end entity;

architecture behave of a1_4_Test  is

--declaration of the Behaviral Encoder
COMPONENT a1_4 is
		port (aPC: in std_logic_vector(31 downto 0);		--PC Input
		      aBRANCH: out std_logic; --1 for equal, 0 for not equal
		      aF_DATA: out std_logic_vector(31 downto 0)); --the control values for alu operation
end COMPONENT;

--Declaration of test signal Inputs
signal TB_aPC: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal TB_aBRANCH: std_logic;		--1 bit Read data output
signal TB_aF_DATA: std_logic_vector(31 downto 0);		--32 bit Read data Output



begin
	uut: a1_4 PORT MAP (
			aPC => TB_aPC,
			aBRANCH => TB_aBRANCH, 
			aF_DATA => TB_aF_DATA);
			
			
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
