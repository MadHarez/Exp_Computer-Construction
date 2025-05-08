`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/22 10:05:27
// Design Name: 
// Module Name: MIPS
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


module MIPS(
    input clk,
    input mclk,
    input [9:0] addr,  // 10位地址线（Depth=1024）  
    output wire [2:0] which,   // 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg,     // 段选信号（点亮哪些笔划），低电平有效
    output reg enable    // 数码管显示  
    );
    wire [31:0] data_out;
    wire [14:0] count;
    wire [3:0] digit;
    RAM_B ram_b_ins(
    .clka(mclk),      // 时钟信号
    .wea(1'b0),      // 写使能（0=只读）
    .addra(addr),    // 地址输入
    .dina(32'b0),    // 数据输入（未使用，因为只读）
    .douta(data_out) // 数据输出); 
     );
     Display Display_init(
     .clk(clk),
     .Inst_code(data_out),
     .which(which),
     .seg(seg),
     .count(count),
     .digit(digit)
     );
    
endmodule
