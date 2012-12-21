--Data_Memory: Just has 2 values for the memory one for SW and LW
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity Data_Memory is
   port (ADDR: in std_logic_vector(31 downto 0); 	--32-bit Address location
	     WD: in std_logic_vector(31 downto 0); 		--32-bit data
		 Control: in std_logic_vector(5 downto 0);  --LW for Read SW for Write
		 RD: out std_logic_vector(31 downto 0));	--32-bit data at specific address, only going to output when lw
end entity Data_Memory;

architecture behave of Data_Memory is 

signal MEM_164: std_logic_vector(31 downto 0) := x"00001234";	--For lw, data will be put into Reg 19
signal MEM_1F8: std_logic_vector(31 downto 0) := x"00001111";	--For sw, data will change to $200
signal MEM_ERROR: std_logic_vector(31 downto 0) := x"FFFFFFFF";	--For sw, data will change to $200

begin 
	RD <= MEM_164 when (ADDR = x"00000164" and Control = "100011") else
		  MEM_1F8 when (ADDR = x"000001F8" and Control = "100011") else
		  Mem_ERROR;
	
  --MEM_164 <= WD when (ADDR = x"00000164" and Control = "101011");
	MEM_1F8 <= WD when (ADDR = x"000001F8" and Control = "101011");
end architecture behave;
