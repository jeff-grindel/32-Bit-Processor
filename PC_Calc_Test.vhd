--PC_Calc
-- TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity PC_Calc_Test is
end entity;

architecture behave of PC_Calc_Test is

--declaration of the Behaviral Encoder
COMPONENT PC_Calc is
	port (PC_IN: in std_logic_vector(31 downto 0);   --32-bit PC
		  IMM: in std_logic_vector(31 downto 0);		--32-bit Immidiate value
	 	  Branch: in std_logic;						--Branch Control Signal from ALU
		  Control: in std_logic_vector(5 downto 0);	--Control signal from Instruction Mem
		  X_Type: in std_logic_vector(1 downto 0); 	--Type of instruction: Going to be used for Jump Instruction "01"
		  PC_OUT: out std_logic_vector(31 downto 0)); 	--32-bit PC output
end COMPONENT;

--Declaration of test signal Inputs
signal TB_PC_IN: std_logic_vector(31 downto 0);
signal TB_IMM: std_logic_vector(31 downto 0);
signal TB_Branch: std_logic;
signal TB_Control: std_logic_vector(5 downto 0);
signal TB_X_TYPE: std_logic_vector(1 downto 0);

--Declaration of test signal Outputs
signal TB_PC_OUT: std_logic_vector(31 downto 0);

begin
	uut: PC_Calc PORT MAP (
			PC_IN => TB_PC_IN,
			IMM => TB_IMM,
			Branch => TB_Branch,
			Control => TB_Control,
			X_TYPE => TB_X_TYPE,
			PC_OUT => TB_PC_OUT);
			
	PC_GEN: process
	begin
		TB_PC_IN <= x"00000500" after 0 ns,	--lw
				 x"00000504" after 10 ns,	--sw
				 x"00000508" after 20 ns,	--add
				 x"0000050C" after 30 ns,	--or
				 x"00000510" after 40 ns,	--slt
				 x"00000514" after 50 ns,	--beq
				 x"00000518" after 60 ns,	--j
				 x"0000051C" after 70 ns,	--bne
				 x"00000520" after 80 ns,	--ori
				 x"00000524" after 90 ns,	--srl
				 x"00000528" after 100 ns,	--lui
				 x"00000530" after 110 ns; 	--EMPTY
	wait;
	end process PC_GEN;
	
	IMM_GEN: process
	begin
		TB_IMM <= x"00000001" after 0 ns,
				  x"0000003B" after 50 ns, -- BEQ for 2 cycles to test Branch Control
				  x"0000003B" after 55 ns, -- BEQ for 2 cycles to test Branch Control
				  x"000000AF" after 60 ns, -- Jump instruction
				  x"00000039" after 70 ns, -- BNE for 2 cycles to test Branch Control
				  x"00000039" after 75 ns, -- BNE for 2 cycles to test Branch Control
				  x"00000001" after 80 ns, 
				  x"FFFFFFFF" after 110 ns; --END
	wait;
	end process IMM_GEN;
	
	Branch_GEN: process
	begin
		TB_Branch <= '0' after 0 ns,
					 '1' after 50 ns,
					 '0' after 55 ns,
					 '1' after 70 ns,
					 '0' after 75 ns;
	wait;
	end process Branch_GEN;
	
	Control_GEN: process
	begin
		TB_Control <= "000000" after 0 ns,
					  "000100" after 50 ns, --BEQ 
					  "000000" after 60 ns,
					  "000101" after 70 ns,	--BNE
					  "000000" after 80 ns,
					  "111111" after 110 ns;
	
	wait;
	end process Control_GEN;
	
	X_TYPE_GEN: process
	begin
		TB_X_TYPE <= "00" after 0 ns, 
					 "01" after 60 ns,
					 "00" after 70 ns,
					 "11" after 110 ns;
	
	wait;
	end process X_TYPE_GEN;
end architecture behave;	
