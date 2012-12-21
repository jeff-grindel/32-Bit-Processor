--Combination of Instruction Memory and Instruction Decode
--
library ieee;
use ieee.std_logic_1164.all;

entity a1_2 is
	port (aPC: in std_logic_vector(31 downto 0);
			aRS: out std_logic_vector(4 downto 0);		--5-bit RS output
			aRT: out std_logic_vector(4 downto 0);		--5-bit RT output
			aRD: out std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
			aIMM: out std_logic_vector(15 downto 0);	--5-bit IMM output(I-Type only)
			aSHMT: out std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
			aFUNCT: out std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
			aX_TYPE: out std_logic_vector(1 downto 0));	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
end entity a1_2;
	
architecture behave of a1_2 is

signal TEMP_INST: std_logic_vector(31 downto 0);

component Instruction_Memory
	port (PC: in std_logic_vector(31 downto 0); 	--32-bit instruction
			INSTRUCTION: out std_logic_vector(31 downto 0)); --32-bit instruction(hardcoded in)
end component;

component Instruction_Decode 
	port (INST: in std_logic_vector(31 downto 0);    --32-bit instruction
			RS: out std_logic_vector(4 downto 0);		--5-bit RS output
			RT: out std_logic_vector(4 downto 0);		--5-bit RT output
			RD: out std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
			IMM: out std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
			SHMT: out std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
			FUNCT: out std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
			X_TYPE: out std_logic_vector(1 downto 0));	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
end component;

begin

label1: Instruction_Memory port map(PC => aPC, INSTRUCTION => TEMP_INST);
label2: Instruction_Decode port map(INST => TEMP_INST, RS => aRS, RT => aRT, RD => aRD, IMM => aIMM, SHMT => aSHMT, FUNCT => aFUNCT, X_TYPE => aX_TYPE);
end architecture behave;	
