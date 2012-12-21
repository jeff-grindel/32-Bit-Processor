--Insturction Decoder 
--Input 32-bit Instruction In binary/hex format
--Output a 26-bit output that is J-type, R-type, or I-Type
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Decode is
   port (INST: in std_logic_vector(31 downto 0);    --32-bit instruction
		RS: out std_logic_vector(4 downto 0);		--5-bit RS output
		RT: out std_logic_vector(4 downto 0);		--5-bit RT output
		RD: out std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
		IMM: out std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
		SHMT: out std_logic_vector(4 downto 0);		--5-bit Shift Amount (R-Type only) --was 10 down to 6
		FUNCT: out std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
		X_TYPE: out std_logic_vector(1 downto 0));	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
end entity Instruction_Decode;

architecture behave of Instruction_Decode is 

signal TEMP: std_logic_vector(1 downto 0);	

begin 
	TEMP <= "10" when INST = x"8D530064" else	--lw
			  "10" when INST = x"ADB400C8" else --sw
			  "00" when INST = x"01525820" else --add			  
			  "00" when INST = x"02CD6825" else --or
			  "00" when INST = x"022A702A" else --slt
 			  "10" when INST = x"11B2003B" else --beq
			  "01" when INST = x"080000AF" else --j
			  "10" when INST = x"15B20039" else --bne
			  "10" when INST = x"35CD000A" else --ori
			  "00" when INST = x"00097142" else --srl
			  "10" when INST = x"3C0B0028" else --lui
			  "11";		   
	  
	X_TYPE <= TEMP;  
	  
	RS <= INST(25 downto 21) when (TEMP ="00" or TEMP ="10") else
		  "11111";
	RT <= INST(20 downto 16) when (TEMP ="00" or TEMP ="10") else
		  "11111";
	RD <= INST(15 downto 11) when (TEMP ="00") else
		  "11111";
	IMM <= INST(15 downto 0) when (TEMP ="10" or TEMP ="01") else
		  x"FFFF";
	SHMT <= INST(10 downto 6) when (TEMP ="00") else
	      "11111";
	FUNCT <= INST(5 downto 0) when (TEMP ="00") else		--Function or Opcode, will be used as Control for ALU and Register_Data
			 INST(31 downto 26) when (TEMP ="10") else
		  "111111";
	
end architecture behave;
