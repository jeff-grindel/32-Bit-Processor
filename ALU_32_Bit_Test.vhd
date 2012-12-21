--32-Bit ALU
--Should be good
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity ALU_32_Bit_Test is
end entity;

architecture behave of ALU_32_Bit_Test is

--declaration of the Behaviral Encoder
COMPONENT ALU_32_Bit is
   port (A_DATA: in std_logic_vector(31 downto 0);
		 B_DATA: in std_logic_vector(31 downto 0);
		 CONTROL: in std_logic_vector(5 downto 0);
		 BRANCH: out std_logic; --1 for equal, 0 for not equal
		 F_DATA: out std_logic_vector(31 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TB_A_DATA: std_logic_vector(31 downto 0);								
signal TB_B_DATA: std_logic_vector(31 downto 0);
signal TB_CONTROL: std_logic_vector(5 downto 0);

--Declaration of test signal Outputs
signal TB_BRANCH: std_logic;		--1-bit output to go to zero 
signal TB_F_DATA: std_logic_vector(31 downto 0);		--32-bit output to go to F(output)


begin
	uut: ALU_32_Bit PORT MAP (
		A_DATA => TB_A_DATA,
		B_DATA => TB_B_DATA,
		CONTROL => TB_CONTROL,
		BRANCH => TB_BRANCH,	
		F_DATA => TB_F_DATA);
	
	CONTROL_GEN: process
	begin 
		TB_CONTROL <= "100011" after 0 ns,  --LW
					  "101011" after 10 ns, --SW
					  "100000" after 20 ns, --add
					  "100101" after 30 ns, --OR
					  "101010" after 40 ns, --SLT
					  "000100" after 50 ns, --BEQ
					  "000101" after 60 ns, -- BNE
					  "001101" after 70 ns, --ORI
					  "000010" after 80 ns, --SRL
					  "001111" after 90 ns, --LUI
					  "111111" after 100 ns; -- ERROR
		wait;
	end process CONTROL_GEN;
	
	A_GEN: process
	begin
		TB_A_DATA <= x"00000100" after 0 ns,	--LW
					 x"00000130" after 10 ns, 	--SW
					 x"00000100" after 20 ns,	--add
					 x"00000220" after 30 ns,	--OR
					 x"00000170" after 40 ns, 	--SLT
					 x"00000130" after 50 ns, 	--BEQ
					 x"00000130" after 60 ns, 	--BNE
					 x"00000140" after 70 ns, 	--ORI
					 x"00000005" after 80 ns, 	--SRL
					 x"00000028" after 90 ns, 	--LUI -- NOT A WORKING TEST					 
					 x"FFFFFFFF" after 100 ns;
	wait;
	end process A_GEN;
	
	B_GEN: process
	begin
		TB_B_DATA <= x"00000064" after 0 ns,	--LW
				     x"000000C8" after 10 ns,	--sw
					 x"00000180" after 20 ns,	--ADD
					 x"00000130" after 30 ns,	--OR
					 x"00000100" after 40 ns,	--SLT
					 x"00000130" after 50 ns,	--BEQ
					 x"00000180" after 60 ns,	--BNE
					 x"0000000A" after 70 ns,	--ORI
					 x"00000090" after 80 ns,	--SRL
					 x"00000110" after 90 ns,	--LUI --NOT A WORKING TEST
					 x"FFFFFFFF" after 100 ns;
	
	wait;
	end process B_GEN;
end architecture behave;	
