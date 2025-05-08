`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 01:13:23 PM
// Design Name: 
// Module Name: REGS_ALU
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


module REGS_ALU(
    input clk,
    input rst,
    input [3:0]ALU_OP,
    input Write_Reg,
    
    input rt_imm_s,
    input [31:0]imm_data,
    
    input [4:0]rs_addr, 
    input [4:0]rt_addr,     
    input alu_mem_s,
    input [31:0]M_R_Data,
    
    
    
    
    output reg [31:0]F,
    output reg OF,
    output reg ZF
    );
    wire [31:0]R_Data_A;
    wire [31:0]R_Data_B;  
    wire [4:0]W_Addr;
    wire [31:0]B;
    
   assign W_Addr = (rd_rt_s)?rt_addr:rd_addr;
   assign imm_data = (imm_s)?,imm}:,imm};
   assign W_Data = alu_mem_s?M_R_Data:F;
    
   REGS REGS_init(
   .clk(clk),
   .rst(rst),
   .Write_Reg(Write_Reg),
   .W_Data(W_Data),
   .R_Addr_A(rs_addr),
   .R_Addr_B(R_Addr_B),
   .W_Addr(W_Addr),
   .R_Data_A(R_Data_A),
   .R_Data_B(R_Data_B),
   );
   assign B = (rt_imm_s)?imm_data:R_Data_B;
   
   ALU ALU_init(
    .clk(clk),
    .ALU_OP(ALU_OP),
    .A(R_Data_A),
    .B(B),
    .F(F),
    .OF(OF),
    .ZF(ZF));   
endmodule
