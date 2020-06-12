module MUX4x16(sel,
A,B,C,D,x);
input [15:0] A,B,C,D;
output [15:0] x;
reg [15:0] x;
input [1:0] sel;
always@(sel or A or B or C or D)
begin
	if( sel == 0 )
		begin
		x = A;
		end
	else if( sel == 1 )
		begin
		x = B;
		end
	else if( sel == 2 )
		begin
		x = C;
		end
	else 
		begin
		x = D;
		end
end
endmodule
	