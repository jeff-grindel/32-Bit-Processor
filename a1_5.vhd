--Combination of Instruction Memory, Instruction Decode, 
--Register, and ALU and misc. MUX's and Sign extenders, Data Memory, and pc generation
--Final version of the Datapath of the 32-bit processor
--Jeff Grindel, Tom Demeter
library ieee;
use ieee.std_logic_1164.all;

entity a1_5 is
	port (aPC: in std_logic_vector(31 downto 0);		--PC Input
		  aPC_OUT: out std_logic_vector(31 downto 0);
		  aF_DATA: out std_logic_vector(31 downto 0);
		  aTEMP_TYPE: out std_logic_vector(1 downto 0));
end entity a1_5;
	
architecture behave of a1_5 is

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
signal TEMP_BRANCH: std_logic;
signal TEMP_F_DATA: std_logic_vector(31 downto 0);
signal TEMP_MEM_RD: std_logic_vector(31 downto 0);
signal TEMP_Reg_Write: std_logic_vector(0 downto 0);
signal TEMP_Reg_Value: std_logic_vector(31 downto 0);

component Instruction_Memory
	port (PC: in std_logic_vector(31 downto 0); 			--32-bit instruction
			INSTRUCTION: out std_logic_vector(31 downto 0)); --32-bit instruction(hardcoded in)
end component;

component Instruction_Decode 
	port (INST: in std_logic_vector(31 downto 0);   	 --32-bit instruction
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
		 RR2: in std_logic_vector(4 downto 0);			--5-bit Read Reg. 2 
		 WR: in std_logic_vector(4 downto 0);			--5-bit Write Register
		 WD: in std_logic_vector(31 downto 0);			--32-bit Write Data
		 Control: in std_logic_vector(5 downto 0);		--6-bit Opcode/Function
		 RD1: out std_logic_vector(31 downto 0); 		--32-bit output1
		 RD2: out std_logic_vector(31 downto 0); 		--32-bit output2
		 CTRL_OUT: out std_logic_vector(5 downto 0));	--Control Output to pass through the control values for alu operation
end component;

component ALU_32_Bit
   port (A_DATA: in std_logic_vector(31 downto 0);		--32-bit A input
		 B_DATA: in std_logic_vector(31 downto 0);		--32-bit B input
		 CONTROL: in std_logic_vector(5 downto 0);		--6-bit control
		 BRANCH: out std_logic; 						--1 for BRANCH, 0 for not BRANCH
		 F_DATA: out std_logic_vector(31 downto 0));	--32-bit ALU output
end component;

component Data_Memory
   port (ADDR: in std_logic_vector(31 downto 0); 		--32-bit Address location
	     WD: in std_logic_vector(31 downto 0); 			--32-bit data
		 Control: in std_logic_vector(5 downto 0);  	--LW for Read SW for Write
		 RD: out std_logic_vector(31 downto 0));		--32-bit data at specific address, only going to output when lw
end component;

component Mux_2
	port (ZERO: in std_logic_vector(4 downto 0);		--Zero Input for 5-bit mux
		  ONE: in std_logic_vector(4 downto 0);			--One input for 5-bit mux
	      CTRL: in std_logic_vector(1 downto 0);		--Control signal
		  OUTPUT: out std_logic_vector(4 downto 0));	--5-bit output
end component;

component Mux2_32										--Mux for B_Data of ALU
	port (ZERO: in std_logic_vector(31 downto 0);		--Zero Input for 32-bit mux 
		  ONE: in std_logic_vector(31 downto 0);		--One Input for 32-bit mux
		  CTRL: in std_logic_vector(5 downto 0);		--Control signal
		  OUTPUT: out std_logic_vector(31 downto 0));	--32-bit output
end component;

component Mux2_32_1										--Mux for Write Data 
	port (ZERO: in std_logic_vector(31 downto 0);		--Zero Input for 32-bit mux
		  ONE: in std_logic_vector(31 downto 0);		--One Input for 32-bit mux
		  CTRL: in std_logic_vector(5 downto 0);		--Control signal
		  OUTPUT: out std_logic_vector(31 downto 0));	--32-bit output
end component;

component Mux_3											--Mux for A_Data of ALU
	port (ZERO: in std_logic_vector(31 downto 0);		--Zero input for 32-bit mux
		  ONE: in std_logic_vector(31 downto 0);		--One input for 32-bit mux
		  TWO: in std_logic_vector(31 downto 0);		--Two inptu for 32-bit mux
		  CTRL: in std_logic_vector(5 downto 0);		--Controla signla
		  OUTPUT: out std_logic_vector(31 downto 0));	--32-bit output
end component;

component Sign_Extend_5									--Takes 5 bit number and truncattes with 0
	port (INPUT: in std_logic_vector(4 downto 0);		--5-bit Input
		  OUTPUT: out std_logic_vector(31 downto 0));	--32-bit ouput
end component;

component Sign_Extend_16								--Takes 16 bit number and trancates with 0
	port (INPUT: in std_logic_vector(15 downto 0);		--16-bit Input
		  OUTPUT: out std_logic_vector(31 downto 0));	--32-bit output
end component;

component PC_Calc
   port (PC_IN: in std_logic_vector(31 downto 0);   	--32-bit PC
		IMM: in std_logic_vector(31 downto 0);			--32-bit Immidiate value
		Branch: in std_logic;							--Branch Control Signal from ALU
		Control: in std_logic_vector(5 downto 0);		--Control signal from Instruction Mem
		X_Type: in std_logic_vector(1 downto 0); 		--Type of instruction: Going to be used for Jump Instruction "01"
		PC_OUT: out std_logic_vector(31 downto 0)); 	--32-bit PC output
end component;
begin

Instruction_Mem: Instruction_Memory port map(PC => aPC, 
									INSTRUCTION => TEMP_INST);
									
Decode: Instruction_Decode port map(INST => TEMP_INST, 
									RS => TEMP_RS, 
									RT => TEMP_RT, 
									RD => TEMP_RD, 
									IMM => TEMP_IMM, 
									SHMT => TEMP_SHMT, 
									FUNCT => TEMP_FUNCT, 
									X_TYPE => TEMP_TYPE);
									
Rd_Select: Mux_2 port map(ZERO => TEMP_RT, 
					   ONE => TEMP_RD, 
					   CTRL => TEMP_TYPE, 
					   OUTPUT => TEMP_M2OUT);
					   
Reg_Data: Register_Data port map(RR1 => TEMP_RS, 
							   RR2 => TEMP_RT, 
							   WR => TEMP_M2OUT, 
						       WD => TEMP_Reg_Value, 	 
							   Control => TEMP_FUNCT,
							   RD1 => TEMP_RD1, 
							   RD2 => TEMP_RD2,  
							   CTRL_OUT => TEMP_CTRL_OUT);

Shmt_Extend: Sign_Extend_5 port map(INPUT => TEMP_SHMT, 
							   OUTPUT => TEMP_SE5OUT);	

Imm_Extend: Sign_Extend_16 port map(INPUT => TEMP_IMM,
								OUTPUT => TEMP_SE16OUT);
								

A_Data_Select: Mux_3 port map(ZERO => TEMP_RD1,
					   ONE => TEMP_SE16OUT,
					   TWO => TEMP_SE5OUT,
					   CTRL => TEMP_FUNCT,
					   OUTPUT => TEMP_A_DATA);								
									
B_Data_Select: Mux2_32 port map(ZERO => TEMP_RD2,
						 ONE =>  TEMP_SE16OUT,
						 CTRL => TEMP_FUNCT,
						 OUTPUT => TEMP_B_DATA);
						 					   
ALU: ALU_32_Bit port map(A_DATA => TEMP_A_DATA,
							B_DATA => TEMP_B_DATA,
							CONTROL => TEMP_FUNCT,
							BRANCH => TEMP_BRANCH,
							F_DATA => TEMP_F_DATA);
							
Data_Mem: Data_Memory port map(ADDR => TEMP_F_DATA,
						      WD => TEMP_RD2,
							  Control => TEMP_FUNCT,
							  RD => TEMP_MEM_RD);
							
							
Write_DataMux: Mux2_32_1 port map(ZERO => TEMP_MEM_RD,		
						   ONE => TEMP_F_DATA,
						   CTRL => TEMP_FUNCT,
						   OUTPUT => TEMP_Reg_Value);
						   
PC: PC_Calc port map(PC_IN =>aPC,
						  IMM => TEMP_SE16OUT,
						  Branch => TEMP_BRANCH,
						  Control => TEMP_FUNCT,
						  X_TYPE => TEMP_TYPE,
						  PC_OUT => aPC_OUT);
						  					  		  
	 aF_DATA <= TEMP_F_DATA;
	 aTEMP_TYPE <= TEMP_TYPE;
end architecture behave;	
