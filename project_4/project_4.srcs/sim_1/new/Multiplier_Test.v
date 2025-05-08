`timescale 1ns / 1ps

module Multiplier_tb();

// 输入信号
reg [31:0] sw;
reg key1, key2, sel_ip, clk, rst;

// 输出信号
wire [31:0] led;
wire [7:0] seg;
wire [2:0] which;

// 实例化被测模块
Multiplier uut (
    .sw(sw),
    .key1(key1),
    .key2(key2),
    .sel_ip(sel_ip),
    .clk(clk),
    .rst(rst),
    .led(led),
    .seg(seg),
    .which(which)
);

// 时钟生成（周期 10ns）
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// 初始化输入
initial begin
    // 初始状态
    sw = 32'h0;
    key1 = 0;
    key2 = 0;
    sel_ip = 0;
    rst = 1;  // 初始复位

    // 释放复位
    #20 rst = 0;

    // 测试无符号乘法 (sel_ip=0)
    // 设置 A=3, B=5
    sw = 32'h0000_0003;
    #10 key1 = 1;  // 锁存A
    #10 key1 = 0;
    sw = 32'h0000_0005;
    #10 key2 = 1;  // 锁存B
    #10 key2 = 0;
    #20;  // 等待计算完成
    // 预期结果：product = 15 (0x0000_000F), led=0x0000_0000

    // 测试有符号乘法 (sel_ip=1)
    sel_ip = 1;
    // 设置 A=-3 (0xFFFF_FFFD), B=5
    sw = 32'hFFFF_FFFD;
    #10 key1 = 1;  // 锁存A
    #10 key1 = 0;
    sw = 32'h0000_0005;
    #10 key2 = 1;  // 锁存B
    #10 key2 = 0;
    #20;  // 等待计算完成
    // 预期结果：product = -15 (0xFFFF_FFF1), led=0xFFFF_FFFF

    // 测试复位
    #10 rst = 1;
    #10 rst = 0;
    // 预期结果：A_reg=0, B_reg=0, product=0

    // 结束仿真
    #100 $finish;
end

// 打印输出结果
always @(posedge clk) begin
    $display("Time=%0t: sel_ip=%b, A=0x%h, B=0x%h, product=0x%h_%h, led=0x%h",
        $time, sel_ip, uut.A_reg, uut.B_reg, uut.product[63:32], uut.product[31:0], led);
end

endmodule