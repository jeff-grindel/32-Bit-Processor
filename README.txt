Project: 32-Bit-Processor 
Author: Jeff Grindel 
Project Partner: Tom Demeter
Files: Many O' Files (See Below)
___________________________________________________________________________________________
Description: VHDL Implmentation of a 32-bit limited instruction set MIPS processor.\\

Programs Used: ModelSim (Put Link to Website here) 

Instructions implmented: lw, sw, add, or, slt, beq, bne, ori, srl, lui
		There were set values of the instructions that needed to be implmented, to test these the following
		MIPS instructions were used to test the implmentation.

		lw  $s3,100($t2)
		sw  $s4,200($t5)
		add $t3,$t2,$s2
		or  $t5,$s6,$t5
		slt $t6,$s1,$t2
		beq $t5,$s2,600
		j   700
		bne $t5,$s2,600
		ori $t5,$t6,10
		srl $t6,$t1,10
		lui $t3,40

Files

a1_2.vhd				Combination of Instruction Memory and Instruction Decode
				
a1_2_Test.vhd				Testbench Program for entity a1_2
					
a1_3.vhd				Combination of Instruction Memory, Instruction Decode and Register Data

a1_3_Test.vhd				Testbench Program for entity a1_3

a1_4.vhd				Combination of Instruction Memory, Instruction Decode and Register Data, 
					ALU and misc. MUX's and Sign extenders

a1_4_Test.vhd				Testbench Program for entity a1_4

a1_5.vhd				Combination of all sub modules, Final Version of the DataPath s

a1_5_Test.vhd				Testbench Program for entity a1_5

ALU_32_Bit.vhd				32-Bit ALU: Takes 2 32-bit inputs and determines from the control signals what
					operation needs to take place. It outputs the respective operation and also 
					a branch control signal. 

ALU_32_Bit_Test.vhd			Testbench Program for entity ALU_32_bit

Data_Memory.vhd				Fake data memory used for the implmentation of SW and LW

Data_Memory_Test.vhd			Testbench Program for entity Data_Memory

Instruction_Decode.vhd			Decodes the Instruction which is in binary/hex, it then outputs
					a the specific regiesters (Rs, Rd, Rt), Imm Value, Shift amount, and 
					the function code depending on the Type of Instruction(J-type, R-type, or I-Type)

Instruction_Decode_Test.vhd		Testbench Program for entity Instruction Decode

Instruction_Memory.vhd			Fake memory where the specifc instrctions seen above are hardcoded into specifc PC value.
					The entity takes in a PC value and generates an instruction.

Instruction_Memory_Test.vhd	Testbench Program for entity Instruction Memory

Mux2_32.vhd				2-Input 32-bit wide Mux used for B_Data select

Mux2_32_1.vhd				2-Input 32-bit wide Mux used for writing data

Mux2_32_Test.vhd			Testbench Program for entity Mux2_32_1

Mux_2.vhd				2-Input 5-bit wide Mux

Mux_2_Test.vhd				Testbench Program for entity Mux_2

Mux_3.vhd				3-Input 32-but wide Mux

Mux_3_Test.vhd				Testbench Program for entity Mux_3

PC_Calc.vhd				Calculates the new value for the next PC value, jump, branch, or sequential

PC_Calc_Test.vhd			Testbench Program for entity PC_CALC

Project_Report.pdf			Full project report 

README.txt 				This File

Register_Data.vhd			Simulated register data, able to read and write, Set up to be reloaded everytime a new
					instruction was performed so it was easier to debug.

Register_Data_Test.vhd			Testbench Program for entity Register_Data

Sign_Extend_16.vhd			32-bit sign extention of a 16-bit input

Sign_Extend_16_Test.vhd			Testbench Program for entity Sign_Extend_16

Sign_Extend_5.vhd			32-bit sign extention of a 5-bit input

Sign_Extend_5_Test.vhd			Testbench Program for entity Sign_extend_5

Setup: 	To run this simulated processor ModelSim was used, put all files into a project in ModelSim, and run the file a1_5 for the final
		version of the 32-bit processor. You will need to add the waveforms to see the correct implmentation.
