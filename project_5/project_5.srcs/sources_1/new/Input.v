`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/02 14:58:31
// Design Name: 
// Module Name: Input
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


module Input(
    input input_A,
    input input_B,
    input wire [31:0] input_data,
    output reg [31:0] A,
    output reg [31:0] B
    );
    always @(posedge input_A) begin
        A <= input_data; 
    end
    always @(posedge input_B) begin
        B <= input_data;
    end
endmodule
