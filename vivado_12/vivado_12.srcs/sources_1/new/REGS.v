`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 12:11:55 PM
// Design Name: 
// Module Name: REGS
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


module REGS(
    input clk,
    input rst,
    input Write_Reg,
    
    input [31:0]W_Data,
    input [4:0]R_Addr_A,
    input [4:0]R_Addr_B,
    input [4:0]W_Addr,
    
    output [31:0]R_Data_A,
    output [31:0]R_Data_B
    );
    
   reg [31:0] REG_Files[0:31];
   integer i =0;
   initial
        for(i=0;i<32;i=i+1) REG_Files[i]<=0;
    always @ (posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    for(i=0;i<=31;i=i+1)
                        REG_Files[i]<=0;
                end
            else
                begin
                    if(Write_Reg)
                        REG_Files[W_Addr]<=W_Data;
                end
        end
        assign R_Data_A = REG_Files[R_Addr_A];
        assign R_Data_B = REG_Files[R_Addr_B];
endmodule
