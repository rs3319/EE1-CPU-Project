module StateMachine
(
	input [2:0] S,
	input EXTRA1,
	input EXTRA2,
	input RET,
	output [2:0] NS,
	output FETCH,
	output EXEC1,
	output EXEC2,
	output EXEC3
);

	//original
	/*assign NS[2] = 0;
	assign NS[1] = (~S[1] & S[0] & EXTRA1) | (S[1] & ~S[0] & EXTRA2);
	assign NS[0] = ~S[0] & (~S[1] | EXTRA2);
	
	assign FETCH = ~S[2] & ~S[1] & ~S[0]; //| (S[1] & ~S[0] & ~EXTRA2) | (S[1] & S[0]);
	assign EXEC1 = ~S[2] & ~S[1] & S[0];
	assign EXEC2 = ~S[2] & S[1] & ~S[0];
	assign EXEC3 = ~S[2] & S[1] & S[0];*/
	
	//old pipeline
	/*assign NS[2] = 0;
	assign NS[1] = (~S[1] & S[0] & EXTRA1) | (S[1] & ~S[0] & EXTRA2);
	assign NS[0] = (~RET & ((~S[1] & ~S[0]) | (S[1] & ~S[0]))) | (RET & (~S[0] & (~S[1] | (EXTRA2)))) ;
	
	assign FETCH = ~S[1] & ~S[0];
	assign EXEC1 = ~S[1] & S[0];
	assign EXEC2 = S[1] & ~S[0];
	assign EXEC3 = S[1] & S[0];*/
	
	//new pipeline
	assign NS[2] = ~S[2] & S[1] & S[0] & EXTRA2;
	assign NS[1] = ~S[2] & ~S[1] & S[0] & ((EXTRA1 & ~RET) | ((EXTRA1 & RET) | EXTRA2));
	assign NS[0] = (~S[2] & ~S[1] & ~S[0]) | (~S[2] & ~S[1] & S[0] & ((EXTRA1 & RET) | EXTRA2)) | (~S[2] & S[1] & ~S[0]) | (S[2] & ~S[1] & ~S[0]);
	 

	assign FETCH = (~S[2] & ~S[1] & ~S[0]) | (~S[2] & S[1] & ~S[0]) | (S[2] & ~S[1] & ~S[0]);
	assign EXEC1 = (~S[2] & ~S[1] & S[0]);
	assign EXEC2 = (~S[2] & S[1] & ~S[0]) | (~S[2] & S[1] & S[0]);
	assign EXEC3 = (S[2] & ~S[1] & ~S[0]);
	
	
	
endmodule


