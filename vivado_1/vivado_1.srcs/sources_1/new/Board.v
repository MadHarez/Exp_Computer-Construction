`timescale 1ns / 1ps
// 通过数据输入输出测试开关、LED、数码管；通过数码管使能测试按键
module Board(sw, swb, led, clk, which, seg, enable);
    input [31:0] sw;
    output [31:0] led;
    assign led = sw; // 开关输入数据，直接输出到 LED
    input clk; // 数码管相关
    output [2:0] which;
    output [7:0] seg;
    output reg enable = 1; // 默认开启数码管使能
    Display Display_Instance(
     .clk(clk), 
     .data(sw), 
     .which(which), 
     .seg(seg)
    );
    input [7:0] swb; //注意：1～8 是针对本地板卡的参数，
    //远程板卡上只有 6 个按键，
    //本程序用于远程实验时需要修改参数
    wire toggle;
    assign toggle =|swb; // 按下任意按键切换数码管使能
    always @(posedge toggle) enable <= ~enable;
endmodule