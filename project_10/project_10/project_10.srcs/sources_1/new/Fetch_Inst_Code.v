`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/22 11:44:32
// Design Name: 
// Module Name: Fetch_Inst_Code
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


module Fetch_Inst_Code(
    input clk,rst,
    output wire [31:0] PC_new,
    output wire [2:0] which,// 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg, // 段选信号（点亮哪些笔划），低电平有效
    output reg enable   //默认开启数码管
); 
    wire [3:0]digit;
//    wire [31:0]PC_new;
    wire [2:0]count; // 2:0 sim 14:0 board
    wire [31:0] Inst_code;
    initial enable =1;

    PC_M PC_ins(
    .clk(clk),
    .rst(rst),
    .Inst_code(Inst_code),
    .PC_new(PC_new)
    );
    
    Seg_Display Seg_Display_ins(
    .clk(clk),
    .data(Inst_code), // 根据按键选择显示的数据
    .which(which),
    .seg(seg),
    .count(count),
    .digit(digit)
    );
    
//always @(posedge clk or posedge rst) begin
//    if(rst) begin
//       Inst_code <= 32'h0000_0000;  // 明确赋值为全0
//    end else begin
    
//    end
  
//end
    
endmodule
