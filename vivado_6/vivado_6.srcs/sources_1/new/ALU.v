`timescale 1ns / 1ps

module ALU (
    input wire clk,          // 时钟信号
    input wire rst_n,        // 复位信号，低电平有效
    input wire key1,         // 按键1，用于输入操作数A
    input wire key2,         // 按键2，用于输入操作数B
    input wire key3,         // 按键3，用于设置ALU_OP
    input wire key4,         // 按键4，显示当前操作数 A
    input wire key5,         // 按键5，显示当前操作数 B
    input wire key6,         // 按键6，显示运算结果 F
    input wire [31:0] input_data, // 32位输入数据，用于设置A
    output wire ZF,          // F全0为1，否则为0
    output wire OF,          // 溢出为1，否则为0
    output wire [2:0] which, // 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg,   // 段选信号（点亮哪些笔划），低电平有效
    output reg enable        // 默认开启数码管
);

    // 内部信号
    wire [31:0] A;           // 32位操作数A
    wire [31:0] B;           // 32位操作数B
    wire [31:0] F;           // 32位输出结果F
    wire [3:0] ALU_OP;       // 4位ALU操作码
    wire [2:0] count;        // 分频扫描，从左至右循环驱动每一位数码管
    wire [3:0] digit;        // 显示数据，片选得到十六进制数码

    initial enable = 1;     // 初始化 enable 为 1

    // 实例化子模块
    input_val i_val (
        .clk(clk),
        .rst_n(rst_n),      
        .key1(key1),
        .key2(key2),
        .key3(key3),
        .input_data(input_data),
        .A(A),
        .B(B),
        .ALU_OP(ALU_OP)
    );
    
    op_val o_val(
        .ALU_OP(ALU_OP),
        .A(A),
        .B(B),
        .F(F),
        .ZF(ZF),
        .OF(OF)
    );

    reg [31:0] output_data; // 当前显示的数据
    always @(*) begin
        if (key4) begin
            output_data = A; // 显示A
        end else if (key5) begin
            output_data = B; // 显示B
        end else if (key6) begin
            output_data = F; // 显示F
        end else begin
            output_data = 32'h0000_0000; // 默认显示0
        end
    end

    output_val o_val_display (
        .clk(clk),
        .data(output_data), // 根据按键选择显示的数据
        .which(which),
        .seg(seg),
        .count(count),
        .digit(digit)
    );

endmodule