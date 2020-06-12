module AddressDecode
(
	input [7:0] IR_opcode,
	input [3:0] IR_oldopcode,
	input EXEC1,
	input EXEC2,
	input EXEC3,
	input EQ,
	input MI,
	input [3:0] CMPFlag,
	output PC_sync_load,
	output PC_count_enable,
	output MUX1_select,
	output RAM_write_enable,
	output MUX2sel,
	output MUXLsel,
	output EXTRA1,
	output EXTRA2,
	output pushpop,
	output SP_Cnt,
	output SpMux
);

	wire LDA, STA, ADD, SUB, MUL, JMP, JMI, JEQ, LDI, LDN, SSS, JME, JMG, JGE, CALL, RET, PUSH, POP, INC, DEC, STP;
	
	assign LDA = ~IR_opcode[7] & ~IR_opcode[6] & ~IR_opcode[5] & ~IR_opcode[4];   
	assign STA = ~IR_opcode[7] & ~IR_opcode[6] & ~IR_opcode[5] & IR_opcode[4];
	assign ADD = ~IR_opcode[7] & ~IR_opcode[6] & IR_opcode[5] & ~IR_opcode[4];
	assign SUB = ~IR_opcode[7] & ~IR_opcode[6] & IR_opcode[5] & IR_opcode[4];
	assign MUL = ~IR_opcode[7] & IR_opcode[6] & ~IR_opcode[5] & ~IR_opcode[4]; 
	assign JMP = ~IR_opcode[7] & IR_opcode[6] & ~IR_opcode[5] & IR_opcode[4]; 
	assign JMI = ~IR_opcode[7] & IR_opcode[6] & IR_opcode[5] & ~IR_opcode[4];  
	assign JEQ = ~IR_opcode[7] & IR_opcode[6] & IR_opcode[5] & IR_opcode[4];  
	assign LDI = IR_opcode[7] & ~IR_opcode[6] & ~IR_opcode[5] & ~IR_opcode[4];
	assign LDN = IR_opcode[7] & ~IR_opcode[6] & ~IR_opcode[5] & IR_opcode[4];
	assign SSS = IR_opcode[7] & ~IR_opcode[6] & IR_opcode[5] & ~IR_opcode[4];
	assign JME = IR_opcode[7] & ~IR_opcode[6] & IR_opcode[5] & IR_opcode[4];
	assign JMG = IR_opcode[7] & IR_opcode[6] & ~IR_opcode[5] & ~IR_opcode[4];
	assign JGE = IR_opcode[7] & IR_opcode[6] & ~IR_opcode[5] & IR_opcode[4];
	assign CALL = IR_opcode[7] & IR_opcode[6] & IR_opcode[5] & ~IR_opcode[4];
	assign RET = IR_opcode[7] & IR_opcode[6] & IR_opcode[5] & IR_opcode[4];
	assign PUSH =  SSS & ~IR_opcode[3] & IR_opcode[2] & IR_opcode[1] & IR_opcode[0];
	assign POP = SSS & IR_opcode[3] & ~IR_opcode[2] & ~IR_opcode[1] & ~IR_opcode[0];
	assign INC = SSS & IR_opcode[3] & ~IR_opcode[2] & IR_opcode[1] & ~IR_opcode[0];
	assign DEC = SSS & IR_opcode[3] & ~IR_opcode[2] & IR_opcode[1] & IR_opcode[0];
	assign STP = SSS & ~IR_opcode[3] & ~IR_opcode[2] & ~IR_opcode[1] & ~IR_opcode[0]; 
		
		
	wire OLDLDN;
	assign OLDLDN = IR_oldopcode[3] & ~IR_oldopcode[2] & ~IR_oldopcode[1] & IR_oldopcode[0];
	
	
	assign PC_sync_load = (EXEC1 & (JMP | (JMI & MI) | (JEQ & EQ) | (JME & CMPFlag[0]) | (JMG & CMPFlag[1]) | (JGE & CMPFlag[2]) | CALL)) | (EXEC2 & RET);
	assign PC_count_enable = EXEC1 & (LDA | STA | ADD | SUB | MUL | (JMI & ~MI) | (JEQ & ~EQ) | (JME & ~CMPFlag[0]) | (JMG & ~CMPFlag[1]) | (JGE & ~CMPFlag[2]) | LDI | LDN | (SSS & ~STP));
	assign MUX1_select = (EXEC1 & (LDA | STA | ADD | SUB | MUL | LDN | RET)) | (EXEC2 & LDN);
	assign RAM_write_enable = EXEC1 & (STA | PUSH | CALL);
	assign MUX2sel = EXEC1 | (EXEC2 & LDN);
	assign MUXLsel = (EXEC2 | EXEC3) & OLDLDN;
	assign EXTRA1 = LDA | ADD | SUB | MUL | LDN | POP | RET;
	assign EXTRA2 = LDN;
	assign SpMux = (PUSH | POP | CALL | RET) & EXEC1;
	assign SP_Cnt = SpMux;
	assign pushpop = (POP | RET) & EXEC1;
	
endmodule
