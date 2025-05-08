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
    input [9:0] addr,  // 10λ��ַ�ߣ�Depth=1024��  
    output wire [2:0] which,   // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output wire [7:0] seg,     // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg enable    // �������ʾ  
    );
    wire [31:0] data_out;
    wire [14:0] count;
    wire [3:0] digit;
    RAM_B ram_b_ins(
    .clka(mclk),      // ʱ���ź�
    .wea(1'b0),      // дʹ�ܣ�0=ֻ����
    .addra(addr),    // ��ַ����
    .dina(32'b0),    // �������루δʹ�ã���Ϊֻ����
    .douta(data_out) // �������); 
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
