`timescale 1ns / 1ps

module Divider(
    input clk,                  // 系统时钟（默认引脚）
    input rst,                  // 复位按钮（默认引脚）
    input input_A,              // 输入A
    input input_B,              //输入B
    input sel_meth,               // 切换至IP核运算的按键
    input sel_sign,           // 切换有符号模式的按键
    
    input [31:0] input_data,     // 默认输入值
    
    
    output [7:0] seg,
    output [2:0] which,
    output enable,     // 7段数码管段选
    output [31:0] leds
    
);
    wire [31:0] A;
    wire [31:0] B;
    reg toggle_input;
    
    initial begin
     toggle_input = 0;
    end
    always @(posedge sel_meth) begin
        toggle_input <= ~toggle_input; 
    end

    // 内部信号声明
    reg use_ip = 1'b0;          // 默认使用阵列除法器
    reg signed_mode = 1'b0;     // 默认无符号模式
    
    wire [5:0] array_Q; // 阵列除法器结果
    wire [10:0] array_R; // 阵列除法器结果
    wire [31:0] ip_Q;           // IP核商（32位）
    wire [15:0] ip_R;           // IP核余数（16位）
    reg ip_valid, ip_error;
    
    wire [10:0] count;
    wire [3:0] digit;
    
    Input innput_val(
        .input_A(input_A),
        .input_B(input_B),
        .input_data(input_data),
        .A(A),
        .B(B)
    );

    ArrayDivider array_div (
        .clk(clk),
        .rst(rst),
        .A(A[10:0]),
        .B(B[5:0]),
        .Q(array_Q),
        .R(array_R)
    );
    
    
    Display display_inst (
        .clk(clk),
        .quotient(ip_Q),
        .remainder(ip_R),
        .leds(leds),
        .seg(seg),
        .digit(digit),
        .count(),  // 不使用计数器时可悬空
        .toggle_input(toggle_input),
        .enable(enable),
        .array_Q(array_Q),
        .array_R(array_R)
    );
    
    IP_Divider ip_inst(
        .clk(clk),
        .A(A[31:0]),
        .B(B[15:0]),
        .Q(ip_Q),
        .R(ip_R)
    );
    always @(posedge clk) begin
        $display("IP_Q=%b, IP_R=%b", ip_Q,ip_R);
    end
   
endmodule