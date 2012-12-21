--Register_Data
--Input: Rs, Rt, Rd, Write Data
--Controls
--Outpus: Read Data 1, Read Data 2
-- TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Register_Data_Test is
end entity;

architecture behave of Register_Data_Test is

--declaration of the Behaviral Encoder
COMPONENT Register_Data is
  	 port (RR1: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 1
		   RR2: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 2 
		   WR: in std_logic_vector(4 downto 0);			--5-bit Write Register
		   WD: in std_logic_vector(31 downto 0);		--32-bit Write Data
		   RegWrite: in std_logic_vector(0 downto 0);	--Deasserted: no action Asserted: Register on the Write reg input is written with the value on the write data input
		   Control: in std_logic_vector(5 downto 0);	--6-bit Opcode/Function
		   RD1: out std_logic_vector(31 downto 0); 		--32-bit output1
		   RD2: out std_logic_vector(31 downto 0); 		--32-bit output2
		   CTRL_OUT: out std_logic_vector(5 downto 0));	--Control Output to pass through the control values for alu operation
end COMPONENT;

--Declaration of test signal Inputs
signal TB_RR1: std_logic_vector(4 downto 0);								
signal TB_RR2: std_logic_vector(4 downto 0);								
signal TB_WR: std_logic_vector(4 downto 0);								
signal TB_WD: std_logic_vector(31 downto 0);
signal TB_RegWrite: std_logic_vector(0 downto 0);
signal TB_Control: std_logic_vector(5 downto 0);

--Declaration of test signal Outputs
signal TB_RD1: std_logic_vector(31 downto 0);		
signal TB_RD2: std_logic_vector(31 downto 0);
signal TB_CTRL_OUT: std_logic_vector(5 downto 0);

begin
	uut: Register_Data PORT MAP (
			RR1 => TB_RR1,
			RR2 => TB_RR2,
			WR => TB_WR,
			WD => TB_WD,
			RegWrite => TB_RegWrite,
			Control => TB_Control,
			RD1 => TB_RD1,
			RD2 => TB_RD2,
			CTRL_OUT => TB_CTRL_OUT);
			
	Reg_Write_Gen: process
	begin
		TB_RegWrite <= "0" after 0 ns,
					   "1" after 180 ns,
					   "0" after 360 ns;
	wait;
	end process Reg_Write_Gen;
	
	Read_Reg1_Gen: process
	begin 
		TB_RR1 <= "01000" after 0 ns,
			      "01001" after 10 ns,
			      "01010" after 20 ns,
			      "01011" after 30 ns,
			      "01100" after 40 ns,
			      "01101" after 50 ns,
			      "01110" after 60 ns,
			      "01111" after 70 ns,
			      "10000" after 80 ns,
			      "10001" after 90 ns,
			      "10010" after 100 ns,
				  "10011" after 110 ns,
			      "10100" after 120 ns,
			      "10101" after 130 ns,
			      "10110" after 140 ns,
			      "10111" after 150 ns,
			      "11000" after 160 ns,
			      "11001" after 170 ns,
				  "11111" after 180 ns,
				  "01000" after 360 ns,
			      "01001" after 370 ns,
			      "01010" after 380 ns,
			      "01011" after 390 ns,
			      "01100" after 400 ns,
			      "01101" after 410 ns,
			      "01110" after 420 ns,
			      "01111" after 430 ns,
			      "10000" after 440 ns,
			      "10001" after 450 ns,
			      "10010" after 460 ns,
				  "10011" after 470 ns,
			      "10100" after 480 ns,
			      "10101" after 490 ns,
			      "10110" after 500 ns,
			      "10111" after 510 ns,
			      "11000" after 520 ns,
			      "11001" after 530 ns,
				  "11111" after 540 ns;
				  
	wait;
	end process Read_Reg1_Gen;
	
	Read_Reg2_Gen: process
	begin 
		TB_RR2 <= "01000" after 0 ns,
			      "01001" after 10 ns,
			      "01010" after 20 ns,
			      "01011" after 30 ns,
			      "01100" after 40 ns,
			      "01101" after 50 ns,
			      "01110" after 60 ns,
			      "01111" after 70 ns,
			      "10000" after 80 ns,
			      "10001" after 90 ns,
			      "10010" after 100 ns,
				  "10011" after 110 ns,
			      "10100" after 120 ns,
			      "10101" after 130 ns,
			      "10110" after 140 ns,
			      "10111" after 150 ns,
			      "11000" after 160 ns,
			      "11001" after 170 ns,
				  "11111" after 180 ns,
				  "01000" after 360 ns,
			      "01001" after 370 ns,
			      "01010" after 380 ns,
			      "01011" after 390 ns,
			      "01100" after 400 ns,
			      "01101" after 410 ns,
			      "01110" after 420 ns,
			      "01111" after 430 ns,
			      "10000" after 440 ns,
			      "10001" after 450 ns,
			      "10010" after 460 ns,
				  "10011" after 470 ns,
			      "10100" after 480 ns,
			      "10101" after 490 ns,
			      "10110" after 500 ns,
			      "10111" after 510 ns,
			      "11000" after 520 ns,
			      "11001" after 530 ns,
				  "11111" after 540 ns;
	wait;
	end process Read_Reg2_Gen;
		
	Write_Reg_Gen: process
	begin
		TB_WR <=  "01000" after 180 ns,
			      "01001" after 190 ns,
			      "01010" after 200 ns,
			      "01011" after 210 ns,
			      "01100" after 220 ns,
			      "01101" after 230 ns,
			      "01110" after 240 ns,
			      "01111" after 250 ns,
			      "10000" after 260 ns,
			      "10001" after 270 ns,
			      "10010" after 280 ns,
				  "10011" after 290 ns,
			      "10100" after 300 ns,
			      "10101" after 310 ns,
			      "10110" after 320 ns,
			      "10111" after 330 ns,
			      "11000" after 340 ns,
			      "11001" after 350 ns,
				  "11111" after 360 ns;
	wait;
	end process Write_Reg_Gen;
	
	Write_Data_Gen: process
	begin
		TB_WD <= x"FFFF0000" after 180 ns,
			      x"FFFF0001" after 190 ns,
			      x"FFFF0002" after 200 ns,
			      x"FFFF0003" after 210 ns,
			      x"FFFF0004" after 220 ns,
			      x"FFFF0005" after 230 ns,
			      x"FFFF0006" after 240 ns,
			      x"FFFF0007" after 250 ns,
			      x"FFFF0008" after 260 ns,
			      x"FFFF0009" after 270 ns,
			      x"FFFF000A" after 280 ns,
				  x"FFFF000B" after 290 ns,
			      x"FFFF000C" after 300 ns,
			      x"FFFF000D" after 310 ns,
			      x"FFFF000E" after 320 ns,
			      x"FFFF000F" after 330 ns,
			      x"FFFF0010" after 340 ns,
			      x"FFFF0011" after 350 ns,
				  "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" after 360 ns;
	wait;
	end process Write_Data_Gen;	

		
end architecture behave;	
