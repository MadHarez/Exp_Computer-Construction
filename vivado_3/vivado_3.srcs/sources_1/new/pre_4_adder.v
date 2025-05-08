`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/11 21:14:44
// Design Name: 
// Module Name: pre_4_adder
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


module pre_4_adder(A,B,c0,F,c4);
input [3:0] A;
input [3:0] B;
input c0;
output [3:0]F;
output c4;
    assign g0 = A[0] & B[0];
    assign g1 = A[1] & B[1];
    assign g2 = A[2] & B[2];
    assign g3 = A[3] & B[3];
    assign p0 = A[0] | B[0];
    assign p1 = A[1] | B[1];
    assign p2 = A[2] | B[2];
    assign p3 = A[3] | B[3];
    assign c1 = g0 | (p0 & c0);
    assign c2 = g1 | (p1 & g0) | (p1 & p0 & c0);
    assign c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & c0);
    assign c4 = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & c0);
    assign F[0] = A[0] ^ B[0] ^ c0;
    assign F[1] = A[1] ^ B[1] ^ c1;
    assign F[2] = A[2] ^ B[2] ^ c2;
    assign F[3] = A[3] ^ B[3] ^ c3;
endmodule
