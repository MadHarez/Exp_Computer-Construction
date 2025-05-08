`timescale 1ns / 1ps
// 8 位七段数码管扫描显示模块 + LED输出
module Display(
    input clk,           // 接入系统时钟
    input [63:0] data,   // 64位输入数据（高32位给LED，低32位给数码管）
    output reg [31:0] led_out, // 32位LED输出（显示高32位）
    output reg [2:0] which = 0, // 片选编码（驱动哪一位数码管），低电平有效
    output reg [7:0] seg,      // 段选信号（点亮哪些笔划），低电平有效
    output reg [14:0] count = 0, // 分频扫描，从左至右循环驱动每一位数码管
    output reg [3:0] digit      // 显示数据 片选得到 十六进制数码
);

// 将高32位直接输出到LED
always @(*) begin
    led_out = data[63:32];
end

// 数码管扫描逻辑
always @(posedge clk) count <= count + 1'b1; 
always @(negedge clk) if (&count) which <= which + 1'b1; 

// 从低32位中选择当前要显示的数码
always @(*) 
    case (which)
         0: digit <= data[31:28]; // 最高位
         1: digit <= data[27:24];
         2: digit <= data[23:20];
         3: digit <= data[19:16];
         4: digit <= data[15:12];
         5: digit <= data[11:08];
         6: digit <= data[07:04];
         7: digit <= data[03:0]; // 最低位
    endcase

// 数码管译码逻辑
always @(*)
  case (digit) // 十六进制数码 转换为 段选信号（ca,cb,cc,...cg,dp）
     4'h0: seg <= 8'b0000_0011; // 除 g、dp 外全亮，显示数码 0
     4'h1: seg <= 8'b1001_1111; // 仅 b、c 亮，显示数码 1
     4'h2: seg <= 8'b0010_0101; 
     4'h3: seg <= 8'b0000_1101; 
     4'h4: seg <= 8'b1001_1001; 
     4'h5: seg <= 8'b0100_1001; 
     4'h6: seg <= 8'b0100_0001; 
     4'h7: seg <= 8'b0001_1111; 
     4'h8: seg <= 8'b0000_0001; 
     4'h9: seg <= 8'b0000_1001; 
     4'hA: seg <= 8'b0001_0001; 
     4'hB: seg <= 8'b1100_0001; 
     4'hC: seg <= 8'b0110_0011; 
     4'hD: seg <= 8'b1000_0101; 
     4'hE: seg <= 8'b0110_0001; 
     4'hF: seg <= 8'b0111_0001; 
  endcase
endmodule