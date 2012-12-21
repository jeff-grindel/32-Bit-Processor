--Instruction Memory: Where all the opcodes for the specific instructions are stored
--Takes in a PC value and generates what insturction it is.
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Instruction_Memory is
   port (PC: in std_logic_vector(31 downto 0); 	--32-bit instruction
	     INSTRUCTION: out std_logic_vector(31 downto 0)); --32-bit instruction(hardcoded in)
end entity Instruction_Memory;

architecture behave of Instruction_Memory is 
begin 
	INSTRUCTION <= 	x"8D530064" when PC = x"00000500" else	--lw
				    x"ADB400C8" when PC = x"00000504" else  --sw
					x"01525820" when PC = x"00000508" else  --add
					x"02CD6825" when PC = x"0000050C" else  --or
					x"022A702A" when PC = x"00000510" else  --slt
					x"11B2003B" when PC = x"00000514" else  --beq
					x"080000AF" when PC = x"00000518" else  --j
					x"15B20039" when PC = x"0000051C" else  --bne
					x"35CD000A" when PC = x"00000520" else  --ori
					x"00097142" when PC = x"00000524" else  --slt
					x"3C0B0028" when PC = x"00000528" else  --lui
					x"FFFFFFFF";
end architecture behave;
