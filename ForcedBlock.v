module ForcedBlock
(
	input [15:0] RAMout,
	output [15:0] ForcedLDI
);

	assign ForcedLDI[15] = 0;
	assign ForcedLDI[14] = 0;
	assign ForcedLDI[13] = 0;
	assign ForcedLDI[12] = 0;

	assign ForcedLDI[11:0] = RAMout[11:0];
	

endmodule
	
