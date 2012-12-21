--Data_Memory
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory_Test is
end entity;

architecture behave of Data_Memory_Test is

--declaration of the Behaviral Encoder
COMPONENT Data_Memory is
   port (ADDR: in std_logic_vector(31 downto 0); 	--32-bit Address location
	     WD: in std_logic_vector(31 downto 0); 		--32-bit data
		 Control: in std_logic_vector(5 downto 0);  --LW for Read SW for Write
		 RD: out std_logic_vector(31 downto 0));	--32-bit data at specific address, only going to output when lw
end COMPONENT;

--Declaration of test signal Inputs
signal TB_ADDR: std_logic_vector(31 downto 0);								
signal TB_WD: std_logic_vector(31 downto 0);
signal TB_Control: std_logic_vector(5 downto 0);
								
--Declaration of test signal Outputs
signal TB_RD: std_logic_vector(31 downto 0);		--5-bit output to go to Rs

begin
	uut: Data_Memory PORT MAP (
			ADDR => TB_ADDR,
			WD => TB_WD,
			Control => TB_Control,
			RD => TB_RD);
			
	ADDR_GEN: process
	begin 
		TB_ADDR <= x"00000164" after 0 ns,
				   x"000001F8" after 10 ns,
				   x"000001F8" after 20 ns,
				   x"00000164" after 30 ns,
				   x"FFFFFFFF" after 40 ns;
	wait;
	end process ADDR_GEN;
	
	WD_GEN: process
	begin 
		TB_WD <= x"00002222" after 0 ns;
				  
	wait;
	end process WD_GEN;
	
	MemWrite_GEN: process
	begin 
		TB_Control <= "100011" after 0 ns,		--read
					   "101011" after 10 ns,	--write
					   "100011" after 20 ns,	--read
					   "101011" after 30 ns;	--write
					   
	wait;
	end process MemWrite_GEN;
	
	
end architecture behave;	


		
