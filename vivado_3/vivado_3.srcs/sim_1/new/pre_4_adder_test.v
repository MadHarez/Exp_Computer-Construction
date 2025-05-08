`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/11 21:31:47
// Design Name: 
// Module Name: pre_4_adder_test
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


module pre_4_adder_test;
    reg [3:0] A;
	reg [3:0] B;
	reg c0;
	// Outputs
	wire [3:0] F;
	wire c4;
	
	pre_4_adder p4adder (
        .A(A),
        .B(B),
        .c0(c0),
        .F(F),
        .c4(c4)
    );
    initial begin
        A = 4'b0001;
        B = 4'b0001;
        c0 = 0;
        #100;
        A = 4'b0001;
        B = 4'b0001;
        c0 = 1;
        #100;
        A = 4'b1111;
        B = 4'b0001;
        c0 = 1;
        #100;
    end
endmodule
