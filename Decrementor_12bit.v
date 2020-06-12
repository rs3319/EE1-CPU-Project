module Decrementor_12bit
(
	input [11:0] In,
	output [11:0] Out
); 

	assign Out = In - 12'b000000000001;
	
endmodule