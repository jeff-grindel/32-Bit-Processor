--Register_Data
--Input: Rs, Rt, Rd, Write Data
--Controls
--Outpus: Read Data 1, Read Data 2
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_Data is
   port (RR1: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 1
		 RR2: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 2 
		 WR: in std_logic_vector(4 downto 0);		--5-bit Write Register
		 WD: in std_logic_vector(31 downto 0);		--32-bit Write Data
		 Control: in std_logic_vector(5 downto 0);	--6-bit Opcode/Function
		 RD1: out std_logic_vector(31 downto 0); 	--32-bit output1
		 RD2: out std_logic_vector(31 downto 0); 	--32-bit output2
		 CTRL_OUT: out std_logic_vector(5 downto 0));--Control Output to pass through the control values for alu operation
end entity Register_Data;

architecture behave of Register_Data is 

constant C_REG_0: std_logic_vector(31 downto 0) := x"00000000";
constant C_REG_8: std_logic_vector(31 downto 0) := x"00000080";
constant C_REG_9: std_logic_vector(31 downto 0) := x"00000090";
constant C_REG_10: std_logic_vector(31 downto 0) := x"00000100";
constant C_REG_11: std_logic_vector(31 downto 0) := x"00000110";
constant C_REG_12: std_logic_vector(31 downto 0) := x"00000120";
constant C_REG_13: std_logic_vector(31 downto 0) := x"00000130";	--Change to determine BEQ or BNE
constant C_REG_14: std_logic_vector(31 downto 0) := x"00000140";
constant C_REG_15: std_logic_vector(31 downto 0) := x"00000150";
constant C_REG_16: std_logic_vector(31 downto 0) := x"00000160";
constant C_REG_17: std_logic_vector(31 downto 0) := x"00000170";    --check if SLT is working
constant C_REG_18: std_logic_vector(31 downto 0) := x"00000180";
constant C_REG_19: std_logic_vector(31 downto 0) := x"00000190";
constant C_REG_20: std_logic_vector(31 downto 0) := x"00000200";
constant C_REG_21: std_logic_vector(31 downto 0) := x"00000210";
constant C_REG_22: std_logic_vector(31 downto 0) := x"00000220";
constant C_REG_23: std_logic_vector(31 downto 0) := x"00000230";
constant C_REG_24: std_logic_vector(31 downto 0) := x"00000240";
constant C_REG_25: std_logic_vector(31 downto 0) := x"00000250";


--Changing Vectors
signal REG_8: std_logic_vector(31 downto 0) := x"00000080";
signal REG_9: std_logic_vector(31 downto 0) := x"00000090";
signal REG_10: std_logic_vector(31 downto 0) := x"00000100";
signal REG_11: std_logic_vector(31 downto 0) := x"00000110";
signal REG_12: std_logic_vector(31 downto 0) := x"00000120";
signal REG_13: std_logic_vector(31 downto 0) := x"00000130";
signal REG_14: std_logic_vector(31 downto 0) := x"00000140";
signal REG_15: std_logic_vector(31 downto 0) := x"00000150";
signal REG_16: std_logic_vector(31 downto 0) := x"00000160";
signal REG_17: std_logic_vector(31 downto 0) := x"00000170";    
signal REG_18: std_logic_vector(31 downto 0) := x"00000180";
signal REG_19: std_logic_vector(31 downto 0) := x"00000190";
signal REG_20: std_logic_vector(31 downto 0) := x"00000200";
signal REG_21: std_logic_vector(31 downto 0) := x"00000210";
signal REG_22: std_logic_vector(31 downto 0) := x"00000220";
signal REG_23: std_logic_vector(31 downto 0) := x"00000230";
signal REG_24: std_logic_vector(31 downto 0) := x"00000240";
signal REG_25: std_logic_vector(31 downto 0) := x"00000250";

signal Write_Control: std_logic := '0';

begin 
		
	--Read Operation
	RD1 <= C_REG_8 when (RR1 =  "01000") else
	       C_REG_9 when (RR1 =  "01001") else
	       C_REG_10 when (RR1 = "01010") else
	       C_REG_11 when (RR1 = "01011") else
	       C_REG_12 when (RR1 = "01100") else
	       C_REG_13 when (RR1 = "01101") else
	       C_REG_14 when (RR1 = "01110") else
	       C_REG_15 when (RR1 = "01111") else
	       C_REG_16 when (RR1 = "10000") else
	       C_REG_17 when (RR1 = "10001") else
	       C_REG_18 when (RR1 = "10010") else
	       C_REG_19 when (RR1 = "10011") else
	       C_REG_20 when (RR1 = "10100") else
	       C_REG_21 when (RR1 = "10101") else
	       C_REG_22 when (RR1 = "10110") else
	       C_REG_23 when (RR1 = "10111") else
	       C_REG_24 when (RR1 = "11000") else
	       C_REG_25 when (RR1 = "11001") else			
	       x"FFFFFFFF";
	
	RD2 <= C_REG_8 when (RR2 = "01000") else
	       C_REG_9 when (RR2 = "01001") else
	       C_REG_10 when (RR2 = "01010") else
	       C_REG_11 when (RR2 = "01011") else
	       C_REG_12 when (RR2 = "01100") else
	       C_REG_13 when (RR2 = "01101") else
	       C_REG_14 when (RR2 = "01110") else
	       C_REG_15 when (RR2 = "01111") else
	       C_REG_16 when (RR2 = "10000") else
	       C_REG_17 when (RR2 = "10001") else
	       C_REG_18 when (RR2 = "10010") else
	       C_REG_19 when (RR2 = "10011") else
	       C_REG_20 when (RR2 = "10100") else
	       C_REG_21 when (RR2 = "10101") else
	       C_REG_22 when (RR2 = "10110") else
	       C_REG_23 when (RR2 = "10111") else
	       C_REG_24 when (RR2 = "11000") else
	       C_REG_25 when (RR2 = "11001") else			
	       x"FFFFFFFF";
	
	Write_Control <= '1' when (Control = "100011" or Control = "100000" or Control = "100101" or Control = "101010" or Control = "001101" or Control = "000010" or Control = "001111") else
					 '0';
	
	--Write Operations
	REG_8 <= WD when (WR = "01000" and Write_Control = '1');
	REG_9 <= WD when (WR = "01001" and Write_Control = '1');
	REG_10 <= WD when (WR = "01010" and Write_Control = '1');
	REG_11 <= WD when (WR = "01011" and Write_Control = '1');
	REG_12 <= WD when (WR = "01100" and Write_Control = '1');
	REG_13 <= WD when (WR = "01101" and Write_Control = '1');
	REG_14 <= WD when (WR = "01110" and Write_Control = '1');
	REG_15 <= WD when (WR = "01111" and Write_Control = '1');
	REG_16 <= WD when (WR = "10000" and Write_Control = '1');
	REG_17 <= WD when (WR = "10001" and Write_Control = '1');
	REG_18 <= WD when (WR = "10010" and Write_Control = '1');
	REG_19 <= WD when (WR = "10011" and Write_Control = '1');
	REG_20 <= WD when (WR = "10100" and Write_Control = '1');
	REG_21 <= WD when (WR = "10101" and Write_Control = '1');
	REG_22 <= WD when (WR = "10110" and Write_Control = '1');
	REG_23 <= WD when (WR = "10111" and Write_Control = '1');
	REG_24 <= WD when (WR = "11000" and Write_Control = '1');
	REG_25 <= WD when (WR = "11001" and Write_Control = '1');
	
	
	CTRL_OUT <= Control;
	
end architecture behave;
