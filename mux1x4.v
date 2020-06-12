module mux1x4(a,b,c,d,sel,out);
input a,b,c,d;
wire a,b,c,d;
input [1:0] sel;
output out;
reg out;
always@(*)
begin
	if(sel == 0)
	begin 
		out = a;
	end
	else if(sel == 1)
	begin 
		out = b;
	end
	else if(sel == 2)
	begin 
		out = c;
	end
	else 
	begin 
		out = d;
	end
end
endmodule 
	