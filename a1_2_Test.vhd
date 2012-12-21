--Combination of Instruction Memory and Instruction Decode
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity a1_2_Test is
end entity;

architecture behave of a1_2_Test  is

--declaration of the Behaviral Encoder
COMPONENT a1_2 is
	port (aPC: in std_logic_vector(31 downto 0);
			aRS: out std_logic_vector(4 downto 0);		--5-bit RS output
			aRT: out std_logic_vector(4 downto 0);		--5-bit RT output
			aRD: out std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
			aIMM: out std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
			aSHMT: out std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
			aFUNCT: out std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
			aX_TYPE: out std_logic_vector(1 downto 0));	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
end COMPONENT;

--Declaration of test signal Inputs
signal TB_aPC: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal TB_aRS: std_logic_vector(4 downto 0);		--5-bit RS output
signal TB_aRT: std_logic_vector(4 downto 0);		--5-bit RT output
signal TB_aRD: std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
signal TB_aIMM: std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
signal TB_aSHMT: std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
signal TB_aFUNCT: std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
signal TB_aX_TYPE: std_logic_vector(1 downto 0);	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
begin
	uut: a1_2 PORT MAP (
			aPC => TB_aPC,
			aRS => TB_aRS,
			aRT => TB_aRT,
			aRD => TB_aRD,
			aIMM => TB_aIMM,
			aSHMT => TB_aSHMT, 
 			aFUNCT => TB_aFUNCT, 
			aX_TYPE => TB_aX_TYPE);			
			
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
