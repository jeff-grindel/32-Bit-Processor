--Combination of Instruction Memory and Instruction Decode and Register Data 
--
library ieee;
use ieee.std_logic_1164.all;

entity a1_3 is
	port (aPC: in std_logic_vector(31 downto 0);		--PC Input
		  aRD1: out std_logic_vector(31 downto 0); 		--32-bit output1
		  aRD2: out std_logic_vector(31 downto 0); 		--32-bit output2
		  aCTRL_OUT: out std_logic_vector(5 downto 0));	--Control Output to pass through the control values for alu operation
end entity a1_3;
	
architecture behave of a1_3 is

signal TEMP_INST: std_logic_vector(31 downto 0);
signal TEMP_RS: std_logic_vector(4 downto 0);
signal TEMP_RT: std_logic_vector(4 downto 0);
signal TEMP_RD: std_logic_vector(4 downto 0);
signal TEMP_IMM: std_logic_vector(15 downto 0);
signal TEMP_SHMT: std_logic_vector(4 downto 0);
signal TEMP_FUNCT: std_logic_vector(5 downto 0);
signal TEMP_TYPE: std_logic_vector(1 downto 0);
signal TEMP_M2OUT: std_logic_vector(4 downto 0);

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

component Register_Data
	 port (RR1: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 1
		 RR2: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 2 
		 WR: in std_logic_vector(4 downto 0);		--5-bit Write Register
		 WD: in std_logic_vector(31 downto 0);		--32-bit Write Data
		 RegWrite: in std_logic_vector(0 downto 0);--Deasserted: no action Asserted: Register on the Write reg input is written with the value on the write data input
		 Control: in std_logic_vector(5 downto 0);	--6-bit Opcode/Function
		 RD1: out std_logic_vector(31 downto 0); 	--32-bit output1
		 RD2: out std_logic_vector(31 downto 0); 	--32-bit output2
		 CTRL_OUT: out std_logic_vector(5 downto 0));--Control Output to pass through the control values for alu operation
end component;

component Mux_2
	port (ZERO: in std_logic_vector(4 downto 0);
			  ONE: in std_logic_vector(4 downto 0);
			  CTRL: in std_logic_vector(1 downto 0);
			  OUTPUT: out std_logic_vector(4 downto 0));
end component;

begin

label1: Instruction_Memory port map(PC => aPC, 
									INSTRUCTION => TEMP_INST);
									
label2: Instruction_Decode port map(INST => TEMP_INST, 
									RS => TEMP_RS, 
									RT => TEMP_RT, 
									RD => TEMP_RD, 
									IMM => TEMP_IMM, 
									SHMT => TEMP_SHMT, 
									FUNCT => TEMP_FUNCT, 
									X_TYPE => TEMP_TYPE);
									
label3: Mux_2 port map(ZERO => TEMP_RT, 
					   ONE => TEMP_RD, 
					   CTRL => TEMP_TYPE, 
					   OUTPUT => TEMP_M2OUT);
					   
label4: Register_Data port map(RR1 => TEMP_RS, 
							   RR2 => TEMP_RT, 
							   WR => TEMP_M2OUT, 
						       WD => x"FFFFFFFF", 
							   RegWrite => "0", 
							   Control => TEMP_FUNCT,
							   RD1 => aRD1, 
							   RD2 => aRD2,  
							   CTRL_OUT => aCTRL_OUT);

end architecture behave;	
