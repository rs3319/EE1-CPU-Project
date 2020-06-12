module MUXMsel
(
	input [3:0] IR_opcode,
	input EXEC2,
	output MUXMsel
);


assign MUXMsel = EXEC2 & IR_opcode[3] & IR_opcode[2] & ~IR_opcode[1] & ~IR_opcode[0];
	
endmodule
	