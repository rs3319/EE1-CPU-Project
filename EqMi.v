module EqMi
(
	input [15:0] Acc,
	output EQ,
	output MI

);

	assign EQ = ~(Acc[15] | Acc[14] | Acc[13] | Acc[12] | Acc[11] | Acc[10] | Acc[9] | Acc[8] | Acc[7] | Acc[6] | Acc[5] | Acc[4] | Acc[3] | Acc[2] | Acc[1] | Acc[0]);
	assign MI = Acc[15];
	

	endmodule
	