module DataDecode
(
	input [15:0] IR_postmux,
	input FETCH,
	input EXEC1,
	input EXEC2,
	input EXEC3,
	input MI,
	output Add_Sub,
	output MUX3_select,
	output [2:0] RegWrite,
	output [2:0] RegReadA,
	output [2:0] RegReadB,
	output Load,
	output Acc_shift_in,
	output Forced,
	output FMOV,
	output ForcedALU,
	output MUXM_select,
	output AccEnable,
	output [1:0] LogSel,
	output Logic,
	output PUSH,
	output CALL,
	output EXEC2RET,
	output IncDec,
	output Compare,
	output [1:0] CarrySel,
	output RET
);

	wire LDA, STA, ADD, SUB, MUL, JMP, JMI, JEQ, LDI, LDN, SSS, JME, JMG, JGE;
	
	assign LDA = ~IR_postmux[15] & ~IR_postmux[14] & ~IR_postmux[13] & ~IR_postmux[12];   
	assign STA = ~IR_postmux[15] & ~IR_postmux[14] & ~IR_postmux[13] & IR_postmux[12];
	assign ADD = ~IR_postmux[15] & ~IR_postmux[14] & IR_postmux[13] & ~IR_postmux[12];
	assign SUB = ~IR_postmux[15] & ~IR_postmux[14] & IR_postmux[13] & IR_postmux[12];
	assign MUL = ~IR_postmux[15] & IR_postmux[14] & ~IR_postmux[13] & ~IR_postmux[12]; 
	assign JMP = ~IR_postmux[15] & IR_postmux[14] & ~IR_postmux[13] & IR_postmux[12]; 
	assign JMI = ~IR_postmux[15] & IR_postmux[14] & IR_postmux[13] & ~IR_postmux[12];  
	assign JEQ = ~IR_postmux[15] & IR_postmux[14] & IR_postmux[13] & IR_postmux[12];  
	assign LDI = IR_postmux[15] & ~IR_postmux[14] & ~IR_postmux[13] & ~IR_postmux[12];
	assign LDN = IR_postmux[15] & ~IR_postmux[14] & ~IR_postmux[13] & IR_postmux[12];
	assign SSS = IR_postmux[15] & ~IR_postmux[14] & IR_postmux[13] & ~IR_postmux[12];
	assign JME = IR_postmux[15] & ~IR_postmux[14] & IR_postmux[13] & IR_postmux[12];
	assign JMG = IR_postmux[15] & IR_postmux[14] & ~IR_postmux[13] & ~IR_postmux[12];
	assign JGE = IR_postmux[15] & IR_postmux[14] & ~IR_postmux[13] & IR_postmux[12];
	assign CALL = IR_postmux[15] & IR_postmux[14] & IR_postmux[13] & ~IR_postmux[12];
	assign RET = IR_postmux[15] & IR_postmux[14] & IR_postmux[13] & IR_postmux[12];

	
	wire STP, LSR, ASR, MOVR, ADDR, SUBR, MULR, POP, CMP, INC, DEC, AND, OR, XOR, NOT;
	
	assign STP = SSS & (~IR_postmux[11] & ~IR_postmux[10] & ~IR_postmux[9] & ~IR_postmux[8]);
	assign LSR = SSS & (~IR_postmux[11] & ~IR_postmux[10] & ~IR_postmux[9] & IR_postmux[8]);
	assign ASR = SSS & (~IR_postmux[11] & ~IR_postmux[10] & IR_postmux[9] & ~IR_postmux[8]);
	assign MOVR = SSS & (~IR_postmux[11] & ~IR_postmux[10] & IR_postmux[9] & IR_postmux[8]);
	assign ADDR = SSS & (~IR_postmux[11] & IR_postmux[10] & ~IR_postmux[9] & ~IR_postmux[8]);
	assign SUBR = SSS & (~IR_postmux[11] & IR_postmux[10] & ~IR_postmux[9] & IR_postmux[8]);
	assign MULR = SSS & (~IR_postmux[11] & IR_postmux[10] & IR_postmux[9] & ~IR_postmux[8]);
	assign PUSH =  SSS & ~IR_postmux[11] & IR_postmux[10] & IR_postmux[9] & IR_postmux[8];
	assign POP = SSS & IR_postmux[11] & ~IR_postmux[10] & ~IR_postmux[9] & ~IR_postmux[8];
	assign CMP = SSS & IR_postmux[11] & ~IR_postmux[10] & ~IR_postmux[9] & IR_postmux[8];
	assign INC = SSS & IR_postmux[11] & ~IR_postmux[10] & IR_postmux[9] & ~IR_postmux[8];
	assign DEC = SSS & IR_postmux[11] & ~IR_postmux[10] & IR_postmux[9] & IR_postmux[8];
	assign AND = SSS & IR_postmux[11] & IR_postmux[10] & ~IR_postmux[9] & ~IR_postmux[8];
	assign OR = SSS & IR_postmux[11] & IR_postmux[10] & ~IR_postmux[9] & IR_postmux[8];
	assign XOR = SSS & IR_postmux[11] & IR_postmux[10] & IR_postmux[9] & ~IR_postmux[8];
	assign NOT = SSS & IR_postmux[11] & IR_postmux[10] & IR_postmux[9] & IR_postmux[8];
	
	wire Accisdest;
	assign Accisdest = ~IR_postmux[7] & ~IR_postmux[6] & ~IR_postmux[5] & ~IR_postmux[4];

	assign EXEC2RET = EXEC2 & RET;
	
	assign FMOV = MOVR;
	assign ForcedALU = ADDR | SUBR | MULR | INC | DEC;	
	
	wire RegRemaining;
	assign RegRemaining = PUSH | POP | CMP | INC | DEC | AND | OR | XOR | NOT;
	
	wire RegInstr;
	assign RegInstr = FMOV | ForcedALU | RegRemaining;
	
	
	assign RegWrite[2] = RegInstr & IR_postmux[6];
	assign RegWrite[1] = RegInstr & IR_postmux[5];
	assign RegWrite[0] = RegInstr & IR_postmux[4];
	
	assign RegReadA[2] = RegInstr & IR_postmux[2];
	assign RegReadA[1] = RegInstr & IR_postmux[1];
	assign RegReadA[0] = RegInstr & IR_postmux[0];
	
	assign RegReadB = RegWrite;
	assign CarrySel[1] = SSS & IR_postmux[7];
	assign CarrySel[0] = SSS & IR_postmux[3];
	assign AccEnable = (EXEC2 & (LDA | ADD | SUB | MUL | POP)) | (EXEC1 & (LDI | LSR | ASR | ((MOVR|ADDR|SUBR|MULR|INC|DEC) & Accisdest))) | (EXEC3 & LDN);
	assign Add_Sub = (EXEC2 & ADD) | (EXEC1 & (ADDR | INC));
	assign MUX3_select = (EXEC3 & LDN) | (EXEC2 & (LDA | POP)) | (EXEC1 & LDI);
	assign Load = (EXEC1 & ~(POP | PUSH)| EXEC2 | EXEC3) & ~(LSR | ASR | CMP | JMP | JMI | JEQ | JME | JMG | JGE);
	assign Acc_shift_in = ASR & MI;
	assign Forced = LDI & EXEC1;
	assign MUXM_select = (EXEC2 & MUL) | (EXEC1 & MULR);
	assign Logic = EXEC1&(AND|OR|XOR|NOT);

	reg [1:0] LogSelTemp;
	always@(AND or OR or XOR or NOT)
	begin
	if(AND)
		begin
		LogSelTemp = 2'b00;
		end
	else if(OR)
		begin
		LogSelTemp = 2'b01;
		end
	else if(XOR)
		begin 
		LogSelTemp = 2'b10;
		end
	else
		begin
		LogSelTemp = 2'b11;
		end
	end
	assign LogSel = LogSelTemp;	
	
	assign IncDec = INC | DEC;
	assign Compare = CMP & EXEC1;
	
endmodule
