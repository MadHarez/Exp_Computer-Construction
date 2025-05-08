`timescale 1ns / 1ps

module RAM_test;

    // 输入信号
    reg [31:0] input_val;
    reg [1:0] keys;
    reg clk;
    reg rst;
    reg Mem_Write;

    // 输出信号
    wire [5:0] addr_led;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // 实例化RAM模块
    RAM uut (
        .input_val(input_val),
        .keys(keys),
        .clk(clk),
        .rst(rst),
        .Mem_Write(Mem_Write),
        .addr_led(addr_led),
        .which(which),
        .seg(seg),
        .enable(enable)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns周期的时钟
    end

    // 测试过程
    initial begin
        // 初始化信号
        input_val = 32'h0000_0000;
        keys = 2'b00;
        rst = 1;
        Mem_Write = 0;

        // 复位
        #20;
        rst = 0;

        // 测试1: 写入第一个数到地址 6'b000001
        #10;
        input_val = 32'h0000_0004; // 地址为 6'b000001 (1)
        keys = 2'b01; // 选择写入地址
        #10;
        keys = 2'b00; // 取消选择

        #10;
        input_val = 32'h1234_5678; // 写入的数据
        keys = 2'b10; // 选择写入数据
        #10;
        keys = 2'b00; // 取消选择

        #10;
        Mem_Write = 1; // 使能写操作
        #10;
        Mem_Write = 0; // 取消写操作

        // 测试2: 写入第二个数到地址 6'b000010
        #10;
        input_val = 32'h0000_0008; // 地址为 6'b000010 (2)
        keys = 2'b01; // 选择写入地址
        #10;
        keys = 2'b00; // 取消选择

        #10;
        input_val = 32'h8765_4321; // 写入的数据
        keys = 2'b10; // 选择写入数据
        #10;
        keys = 2'b00; // 取消选择

        #10;
        Mem_Write = 1; // 使能写操作
        #10;
        Mem_Write = 0; // 取消写操作

        // 测试3: 读取第一个数从地址 6'b000001
        #10;
        input_val = 32'h0000_0004; // 地址为 6'b000001 (1)
        keys = 2'b01; // 选择写入地址
        #10;
        keys = 2'b00; // 取消选择

        // 测试4: 读取第二个数从地址 6'b000010
        #10;
        input_val = 32'h0000_0008; // 地址为 6'b000010 (2)
        keys = 2'b01; // 选择写入地址
        #10;
        keys = 2'b00; // 取消选择

        // 结束测试
        #100;
        $stop;
    end

endmodule