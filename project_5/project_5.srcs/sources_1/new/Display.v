`timescale 1ns / 1ps
module Display(clk,quotient,remainder,seg,digit,count,leds,which,toggle_input,enable,array_Q,array_R,rst);
    input clk,rst;                  // Clock input
    input [31:0] quotient;     // 32-bit quotient input 商数码管
    input [15:0] remainder;   // 16-bit remainder input 余灯
    input toggle_input;           // 0为显示矩阵，1为显示数码管
    input [5:0] array_Q;
    input [10:0] array_R;
    output reg [31:0] leds = 0;     // 32 LED outputs for quotient
    output reg [7:0] seg;      // 7-segment display segments
    output reg [3:0] digit;
    output reg [2:0] count = 0;
    output reg [2:0] which = 0; // 片选编码（驱动哪一位数码管），低电平有效
    output reg enable; //数码管使能信号
        
always @(posedge clk) count <= count + 1'b1; 
always @(negedge clk) if (&count) which <= which + 1'b1; 
always @(*) 
    case (which)
         0: digit <= quotient[31:28]; // 最高位
         1: digit <= quotient[27:24];
         2: digit <= quotient[23:20];
         3: digit <= quotient[19:16];
         4: digit <= quotient[15:12];
         5: digit <= quotient[11:08];
         6: digit <= quotient[07:04];
         7: digit <= quotient[03:0]; // 最低位
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


always @(posedge clk) begin
    enable = toggle_input; 
    if(toggle_input)begin
        //显示ip核
         leds <= { 16'h0 , remainder };  // 高16位=remainder，低16位=0
    end
    else begin
        leds <= {
            array_Q[5:0],  // led[31:26] = array_Q (6 bits)
            10'b0,         // led[25:16] = 0 (10 bits)
            array_R[10:0], // led[15:4] = array_R (12 bits)
            4'b0           // led[3:0] = 0 (4 bits)
        };
    end
//    $display("%b",leds);
end

endmodule