--Combination of Instruction Memory, Instruction Decode, Register, and ALU and misc. MUX's and Sign extenders
--
library ieee;
use ieee.std_logic_1164.all;

entity a1_4 is
	port (aPC: in std_logic_vector(31 downto 0);		--PC Input
		  aBRANCH: out std_logic; --1 for BRANCH, 0 for not BRANCH
		  aF_DATA: out std_logic_vector(31 downto 0));
end entity a1_4;
	
architecture behave of a1_4 is

--Temp Signals used as connections between components
signal TEMP_INST: std_logic_vector(31 downto 0);
signal TEMP_RS: std_logic_vector(4 downto 0);
signal TEMP_RT: std_logic_vector(4 downto 0);
signal TEMP_RD: std_logic_vector(4 downto 0);
signal TEMP_IMM: std_logic_vector(15 downto 0);
signal TEMP_SHMT: std_logic_vector(4 downto 0);
signal TEMP_FUNCT: std_logic_vector(5 downto 0);
signal TEMP_TYPE: std_logic_vector(1 downto 0);
signal TEMP_M2OUT: std_logic_vector(4 downto 0);
signal TEMP_SE5OUT: std_logic_vector(31 downto 0);
signal TEMP_SE16OUT: std_logic_vector(31 downto 0);
signal TEMP_RD1: std_logic_vector(31 downto 0);
signal TEMP_RD2: std_logic_vector(31 downto 0);
signal TEMP_CTRL_OUT: std_logic_vector(5 downto 0);
signal TEMP_A_DATA: std_logic_vector(31 downto 0);
signal TEMP_B_DATA: std_logic_vector(31 downto 0);



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

component ALU_32_Bit
   port (A_DATA: in std_logic_vector(31 downto 0);
		 B_DATA: in std_logic_vector(31 downto 0);
		 CONTROL: in std_logic_vector(5 downto 0);
		 BRANCH: out std_logic; --1 for BRANCH, 0 for not BRANCH
		 F_DATA: out std_logic_vector(31 downto 0));
end component;

component Mux_2
	port (ZERO: in std_logic_vector(4 downto 0);
			  ONE: in std_logic_vector(4 downto 0);
			  CTRL: in std_logic_vector(1 downto 0);
			  OUTPUT: out std_logic_vector(4 downto 0));
end component;

component Mux2_32
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end component;

component Mux_3
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end component;

component Sign_Extend_5
	port (INPUT: in std_logic_vector(4 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end component;

component Sign_Extend_16
	port (INPUT: in std_logic_vector(15 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
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
						       WD => x"FFFFFFFF", 	--Will Need to change around 
							   RegWrite => "0", 	--Will Need to change
							   Control => TEMP_FUNCT,
							   RD1 => TEMP_RD1, 
							   RD2 => TEMP_RD2,  
							   CTRL_OUT => TEMP_CTRL_OUT);

label5: Sign_Extend_5 port map(INPUT => TEMP_SHMT, 
							   OUTPUT => TEMP_SE5OUT);	

label6: Sign_Extend_16 port map(INPUT => TEMP_IMM,
								OUTPUT => TEMP_SE16OUT);
								
label7: Mux2_32 port map(ZERO => TEMP_RD2,
						 ONE =>  TEMP_SE16OUT,
						 CTRL => TEMP_FUNCT,
						 OUTPUT => TEMP_B_DATA);
						 
label8: Mux_3 port map(ZERO => TEMP_RD1,
					   ONE => TEMP_SE16OUT,
					   TWO => TEMP_SE5OUT,
					   CTRL => TEMP_FUNCT,
					   OUTPUT => TEMP_A_DATA);
					   
label9: ALU_32_Bit port map(A_DATA => TEMP_A_DATA,
							B_DATA => TEMP_B_DATA,
							CONTROL => TEMP_FUNCT,
							BRANCH => aBRANCH,
							F_DATA => aF_DATA);
						
end architecture behave;	
