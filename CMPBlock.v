module CMPBlock
(
	input [15:0] OutputA,
	input [15:0] OutputB,
	output [3:0] CMPFlag
);

	wire signed [15:0] a;
	wire signed [15:0] b;
	
	assign a = OutputA;
	assign b = OutputB;
	
	assign CMPFlag[0] = (b == a);
	assign CMPFlag[1] = (b > a);
	assign CMPFlag[2] = (b >= a);
	assign CMPFlag[3] = ~((b == a) | (b > a) | (b >= a));
	
	

endmodule
	
