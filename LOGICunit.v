module LOGICunit(
A,B,AND,OR,XOR,NOT);
input [15:0] A,B;
output [15:0] AND,OR,XOR,NOT;

assign AND = A&B;
assign OR = A|B;
assign NOT = ~A;
assign XOR = A^B;

endmodule 