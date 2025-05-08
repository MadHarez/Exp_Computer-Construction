`timescale 1ns / 1ps

module Fetch_Inst_Code_tb;

    // 输入和输出信号
    reg clk;
    reg rst;
    wire [31:0] PC_new;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // 实例化被测试模块
    Fetch_Inst_Code u0(
        .clk(clk),
        .rst(rst),
        .PC_new(PC_new),
        .which(which),
        .seg(seg),
        .enable(enable)
    );


    // 生成时钟信号
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz 时钟
    end

    // 初始化和测试序列
    initial begin
        // 初始化输入
        rst = 1; // 激活复位
        #10;
        rst = 0; // 释放复位

        // 观察输出变化
        #1000; // 等待一段时间观察输出
        
        rst = 1; // 激活复位
        #10;
        rst = 0; // 释放复位
        #100; // 等待一段时间观察输出
        
        $finish;
    end

    // 监控输出
//    initial begin
//        $monitor("Time = %0t, PC_new = %h, which = %b, seg = %b, enable = %b",
//                 $time, PC_new, which, seg, enable);
//    end

endmodule