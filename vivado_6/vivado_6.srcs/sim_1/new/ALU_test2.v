`timescale 1ns / 1ps

module ALU_tb;

    // 输入信号
    reg clk;          // 时钟信号
    reg rst_n;        // 复位信号，低电平有效
    reg key1;         // 按键1，用于输入操作数A
    reg key2;         // 按键2，用于输入操作数B
    reg key3;         // 按键3，用于设置ALU_OP
    reg key4;         // 按键4，显示当前操作数 A
    reg key5;         // 按键5，显示当前操作数 B
    reg key6;         // 按键6，显示运算结果 F
    reg [31:0] input_data; // 32位输入数据，用于设置A

    // 输出信号
    wire ZF;          // F全0为1，否则为0
    wire OF;          // 溢出为1，否则为0
    wire [2:0] which; // 片选编码（驱动哪一位数码管），低电平有效
    wire [7:0] seg;   // 段选信号（点亮哪些笔划），低电平有效
    wire enable;      // enable 信号

    // 内部信号
//    wire [31:0] A;    // 32位操作数A
//    wire [31:0] B;    // 32位操作数B
//    wire [31:0] F;    // 32位输出结果F
//    wire [3:0] ALU_OP; // 4位ALU操作码
//    wire [2:0] count; // 分频扫描，从左至右循环驱动每一位数码管
//    wire [3:0] digit; // 显示数据，片选得到十六进制数码
    
    // 实例化顶层模块
    ALU uut (
        .clk(clk),
        .rst_n(rst_n),
        .key1(key1),
        .key2(key2),
        .key3(key3),
        .key4(key4),
        .key5(key5),
        .key6(key6),
        .input_data(input_data),
        .ZF(ZF),
        .OF(OF),
        .which(which),
        .seg(seg),
        .enable(enable)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns 周期的时钟
    end

    // 测试逻辑
    initial begin
        // 初始化信号
        rst_n = 0; // 复位
        key1 = 0;
        key2 = 0;
        key3 = 0;
        key4 = 0;
        key5 = 0;
        key6 = 0;
        input_data = 32'h0000_0000;
        #20; // 等待 20ns
        rst_n = 1; // 释放复位

        // 测试按键1：输入操作数A
        input_data = 32'h1234_5678; // 设置输入数据
        key1 = 1; // 按下按键1
        #10;
        key1 = 0; // 释放按键1

        // 测试按键2：输入操作数B
        input_data = 32'h8765_4321; // 设置输入数据
        key2 = 1; // 按下按键2
        #10;
        key2 = 0; // 释放按键2

        // 测试按键3：设置ALU_OP
        input_data = 32'h0000_0004; // 设置ALU_OP为4（假设4表示加法）
        key3 = 1; // 按下按键3
        #10;
        key3 = 0; // 释放按键3

        // 测试按键4：显示操作数A
        key4 = 1; // 按下按键4
        #1000; // 等待一段时间
        key4 = 0; // 释放按键4

        // 测试按键5：显示操作数B
        key5 = 1; // 按下按键5
        #100; // 等待一段时间
        key5 = 0; // 释放按键5

        // 测试按键6：显示运算结果F
        key6 = 1; // 按下按键6
        #100; // 等待一段时间
        key6 = 0; // 释放按键6

        // 测试溢出标志
        input_data = 32'h7FFF_FFFF; // 设置输入数据
        key1 = 1; // 按下按键1
        #10;
        key1 = 0; // 释放按键1

        input_data = 32'h0000_0001; // 设置输入数据
        key2 = 1; // 按下按键2
        #10;
        key2 = 0; // 释放按键2

        input_data = 32'h0000_0004; // 设置ALU_OP为4（假设4表示加法）
        key3 = 1; // 按下按键3
        #10;
        key3 = 0; // 释放按键3

        // 结束仿真
        #100;
        $stop;
    end

endmodule