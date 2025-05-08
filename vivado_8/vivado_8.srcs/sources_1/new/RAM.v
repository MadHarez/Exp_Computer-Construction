`timescale 1ns / 1ps
module RAM(
    input [31:0] input_val,
    input [1:0]keys, // 0为读入Mem_Addr ,1为写入M_W_Data
    input clk,
    input rst, 
    input Mem_Write,                // 写使能信号
    output reg [5:0] addr_led,  // 6位LED灯显示当前存储器地址
    output wire [2:0] which, // 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg, // 段选信号（点亮哪些笔划），低电平有效
    output reg enable //默认开启数码管
);
initial enable = 1; // 初始化 enable 为 1

wire [31:0] M_R_Data; // 8片数码管显示读出的存储器数据
wire [3:0] digit; // 显示数据 片选得到 十六进制数码
wire [2:0] count; // 分频扫描，从左至右循环驱动每一位数码管
reg [7:2] Mem_Addr;             // 存储器地址
reg [31:0] M_W_Data;            // 存储器数据
RAM_B your_instance_name (
  .clka(clk), // input clka
  .wea(Mem_Write), // input [0 : 0] wea
  .addra(Mem_Addr), // input [5 : 0] addra
  .dina(M_W_Data), // input [31 : 0] dina
  .douta(M_R_Data) // output [31 : 0] douta
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Mem_Addr <= 6'b0;
        M_W_Data <= 32'b0;
        addr_led <= 6'b0;
    end else begin
        if (keys[0]) begin
            Mem_Addr <= input_val[7:2];  // 写入地址
        end else if (keys[1]) begin
            M_W_Data <= input_val;  // 写入数据
        end
        // 显示当前地址
        addr_led <= Mem_Addr;
    end
end


    output_val o_val_display (
    .clk(clk),
    .data(M_R_Data), // 根据按键选择显示的数据
    .which(which),
    .seg(seg),
    .count(count),
    .digit(digit)
);

endmodule
