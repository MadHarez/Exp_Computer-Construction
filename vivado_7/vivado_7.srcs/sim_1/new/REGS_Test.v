`timescale 1ns / 1ps

 module REGS_Test;

    // 输入信号
    reg clk;
    reg rst;
    reg Write_Reg;
    reg key1;
    reg key2;
    reg key3;
    reg key4;
    reg Write_T;
    reg Write_val_btn;
    reg [31:0] input_all;

    // 输出信号
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // 内部信号
    wire [31:0] R_Data_A;      // A端口读出数据
    wire [31:0] R_Data_B;      // B端口读出数据
    wire ZF;                   // 零标志
    wire OF;                   // 溢出标志
    wire [31:0] ALU_F;         // ALU运算结果
    wire [10:0] count;         // 分频扫描，从左至右循环驱动每一位数码管
    wire [3:0] digit;          // 显示数据，片选得到十六进制数码
    wire [1:0] out_ZF_OF;      // ZF和OF的输出

    // 实例化被测试模块
    REGS_ALU uut (
        .clk(clk),
        .rst(rst),
        .Write_Reg(Write_Reg),
        .key1(key1),
        .key2(key2),
        .key3(key3),
        .key4(key4),
        .Write_T(Write_T),
        .Write_val_btn(Write_val_btn),
        .input_all(input_all),
        .which(which),
        .seg(seg),
        .enable(enable)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns 周期时钟
    end

    // 测试过程
    initial begin
        // 初始化信号
        rst = 1;
        Write_Reg = 0;
        input_all = 0;
        key1 = 0;
        key2 = 0;
        key3 = 0;
        key4 = 0;
        Write_T = 0;
        Write_val_btn = 0;

        // 复位
        #20;
        rst = 0;

        // 测试 1: 使用 Write_val_btn 写入两个数据到两个不同的地址
        #10;
        input_all[31:27] = 5'b00010; // R_Addr_B = 2
        input_all[19:16] = 5'b00001; // R_Addr_A = 1
        input_all[15:12] = 4'b0000;  // ALU_OP = 0
        input_all[4:0]   = 5'b00001; // W_Addr = 1
        Write_T = 1; // 暂存地址和操作码
        #10;
        Write_T = 0;

        // 使用 Write_val_btn 写入第一个数据到地址 1
        #10;
        input_all = 32'h1234_5678; // 写入数据 0x12345678
        Write_val_btn = 1; // 使用 input_val 写入数据
        #10;
        Write_val_btn = 0;
        #10;

        // 使用 Write_val_btn 写入第二个数据到地址 2
        input_all[4:0] = 5'b00010; // W_Addr = 2
        Write_T = 1;
        #10;
        Write_T = 0;
        #10;
        input_all = 32'h8765_4321; // 写入数据 0x87654321
        Write_val_btn = 1; // 使用 input_val 写入数据
        #10;
        Write_val_btn = 0;

        // 测试 2: 读取寄存器并执行 ALU 操作
        #10;
        input_all[31:27] = 5'b00010; // R_Addr_B = 2
        input_all[19:16] = 5'b00001; // R_Addr_A = 1
        input_all[15:12] = 4'b0100;  // ALU_OP = 4 (加法)
        input_all[4:0]   = 5'b00011; // W_Addr = 3
        Write_T = 1; // 暂存地址和操作码
        #10;
        Write_T = 0;

        // 执行 ALU 操作并显示结果
        key4 = 1;
        key3 = 1;
        #500;
        key4 = 0;
        key1 = 0;
        key2 = 0;
        key3 = 0;
        // 测试 3: 使用 Write_Reg 将 ALU_F 写入寄存器
        #10;
        Write_Reg = 1; // 写入F
        #10;
        Write_Reg = 0;

        // 显示写入后的寄存器值
        #10
//        keys = 4'b0001; // 显示 A
        key1 = 1;
        #500;
        key4 = 0;
        key1 = 0;
        key2 = 0;
        key3 = 0;
//        keys = 4'b0010; // 显示 B        key1 = 1;
        key2 = 1;
        #500;
        
        $stop;
    end
endmodule