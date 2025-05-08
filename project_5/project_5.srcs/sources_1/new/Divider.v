`timescale 1ns / 1ps

module Divider(
    input clk,                  // ϵͳʱ�ӣ�Ĭ�����ţ�
    input rst,                  // ��λ��ť��Ĭ�����ţ�
    input input_A,              // ����A
    input input_B,              //����B
    input sel_meth,               // �л���IP������İ���
    input sel_sign,           // �л��з���ģʽ�İ���
    
    input [31:0] input_data,     // Ĭ������ֵ
    
    
    output [7:0] seg,
    output [2:0] which,
    output enable,     // 7������ܶ�ѡ
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

    // �ڲ��ź�����
    reg use_ip = 1'b0;          // Ĭ��ʹ�����г�����
    reg signed_mode = 1'b0;     // Ĭ���޷���ģʽ
    
    wire [5:0] array_Q; // ���г��������
    wire [10:0] array_R; // ���г��������
    wire [31:0] ip_Q;           // IP���̣�32λ��
    wire [15:0] ip_R;           // IP��������16λ��
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
        .count(),  // ��ʹ�ü�����ʱ������
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