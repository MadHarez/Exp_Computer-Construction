`timescale 1ns / 1ps

module MIPS_tb;

    // 定义时钟信号
    reg clk;
    // 定义地址信号
    reg [9:0] addr;
    // 定义数据输出
    wire [31:0] data_out;

    // 实例化顶层模块
    MIPS mips_ins (
        .clk(clk),
        .addr(addr),
        .data_out(data_out)
    );

    // 初始化时钟信号
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 生成50MHz的时钟信号
    end

    // 测试过程
    initial begin
        // 初始化地址
        addr = 0;
        #10;

        // 逐条读取指令存储器中的指令
        repeat (14) begin
            #10;
            addr = addr + 1;
            $display("Address: %d, Data: %h", addr, data_out);
        end

        // 结束仿真
        #10;
        $finish;
    end

endmodule