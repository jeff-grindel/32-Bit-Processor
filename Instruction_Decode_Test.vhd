--Insturction Decoder 
--Input 32-bit Instruction In binary/hex format
--Output a 26-bit output that is J-type, R-type, or I-Type
-- TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Instruction_Decode_Test is
end entity;

architecture behave of Instruction_Decode_Test is

--declaration of the Behaviral Encoder
COMPONENT Instruction_Decode is
  	 port (INST: in std_logic_vector(31 downto 0);    --32-bit instruction
		RS: out std_logic_vector(4 downto 0);		--5-bit RS output
		RT: out std_logic_vector(4 downto 0);		--5-bit RT output
		RD: out std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
		IMM: out std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
		SHMT: out std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
		FUNCT: out std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
		X_TYPE: out std_logic_vector(1 downto 0));	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
end COMPONENT;

--Declaration of test signal Inputs
signal TB_INST: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal TB_RS: std_logic_vector(4 downto 0);		
signal TB_RT: std_logic_vector(4 downto 0);		
signal TB_RD: std_logic_vector(4 downto 0);		
signal TB_IMM: std_logic_vector(15 downto 0);		
signal TB_SHMT: std_logic_vector(10 downto 6);	
signal TB_FUNCT: std_logic_vector(5 downto 0);	
signal TB_X_TYPE: std_logic_vector(1 downto 0);	

begin
	uut: Instruction_Decode PORT MAP (
			INST => TB_INST,
			RS => TB_RS,
			RT => TB_RT,
			RD => TB_RD,
			IMM => TB_IMM,
			SHMT => TB_SHMT,
			FUNCT => TB_FUNCT,
			X_TYPE => TB_X_TYPE);
			
	LW_GEN: process
	begin
		TB_INST <= 
				   x"8D530064" after 0 ns,
				   x"ADB400C8" after 10 ns,
				   x"01525820" after 20 ns,
				   x"02CD6825" after 30 ns,
				   x"022A702A" after 40 ns,
				   x"11B2003B" after 50 ns,
				   x"080002BC" after 60 ns,
				   x"15B20039" after 70 ns,
				   x"35CD000A" after 80 ns,
				   x"00097142" after 90 ns,
				   x"3C0B0028" after 100 ns,
				   x"FFFFFFFF" after 110 ns;
	wait;
	end process LW_GEN;
end architecture behave;	
