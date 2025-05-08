`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/14 18:14:57
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(ALU_OP,A,B,F,ZF,OF,clk);
    input clk;
    input [3:0] ALU_OP;
    input [31:0] A;
    input [31:0] B;
    output reg [31:0] F;
    output reg ZF;
    output reg OF;
    reg C32 = 0;
//    always@(negedge clk)begin
//       $display("ALU_OP=%b,A=%d,B=%d",ALU_OP,A,B);
//    end
    always @(*) begin
	case(ALU_OP)
			 4'b0000:F<=A&B;
			 4'b0001:F<=A|B;
			 4'b0010:F<=A^B;
			 4'b0011:F<=~(A | B);
			 4'b0100:{C32,F}<=A+B;
			 4'b0101:{C32,F}<=A-B;
			 4'b0110:begin if(A<B)  F<=32'h0000_0001;else F<=32'h0000_0000;end
			 4'b0111:begin F<=B<<A;end
	endcase
	if(F==32'h0000_0000)	
			ZF<=1;
	else
			ZF<=0;
	OF<=C32^F[31]^A[31]^B[31];	
	end
	

endmodule
    