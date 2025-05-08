`timescale 1ns / 1ps
// 8 位七段数码管扫描显示模块
module output_val(clk, Inst_code, which, seg,
 count, digit); // 调试接口
 input clk; // 接入系统时钟
 input [31:0] Inst_code; // 32 位显示数据
 output reg [2:0] which = 0; // 片选编码（驱动哪一位数码管），低电平有效
 output reg [7:0] seg; // 段选信号（点亮哪些笔划），低电平有效
 output reg [14:0] count = 0; // 分频扫描，从左至右循环驱动每一位数码管
 always @(posedge clk) count <= count + 1'b1; 
 always @(negedge clk) if (&count) which <= which + 1'b1; 
 output reg [3:0] digit; // 显示数据 片选得到 十六进制数码
 always @(*) 
    case (which)
         0: digit <= Inst_code[31:28]; // 最高位
         1: digit <= Inst_code[27:24];
         2: digit <= Inst_code[23:20];
         3: digit <= Inst_code[19:16];
         4: digit <= Inst_code[15:12];
         5: digit <= Inst_code[11:08];
         6: digit <= Inst_code[07:04];
         7: digit <= Inst_code[03:0]; // 最低位
 endcase
//数码管原理和设置详见本书 8.4.2 小节，HDU-XL-01 板卡上的数码管采用共阳极方式，
//因此段选为 0 时点亮数码管
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
endmodule // Display
