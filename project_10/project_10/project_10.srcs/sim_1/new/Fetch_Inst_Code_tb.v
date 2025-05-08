`timescale 1ns / 1ps

module Fetch_Inst_Code_tb;

    // ���������ź�
    reg clk;
    reg rst;
    wire [31:0] PC_new;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // ʵ����������ģ��
    Fetch_Inst_Code u0(
        .clk(clk),
        .rst(rst),
        .PC_new(PC_new),
        .which(which),
        .seg(seg),
        .enable(enable)
    );


    // ����ʱ���ź�
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz ʱ��
    end

    // ��ʼ���Ͳ�������
    initial begin
        // ��ʼ������
        rst = 1; // ���λ
        #10;
        rst = 0; // �ͷŸ�λ

        // �۲�����仯
        #1000; // �ȴ�һ��ʱ��۲����
        
        rst = 1; // ���λ
        #10;
        rst = 0; // �ͷŸ�λ
        #100; // �ȴ�һ��ʱ��۲����
        
        $finish;
    end

    // ������
//    initial begin
//        $monitor("Time = %0t, PC_new = %h, which = %b, seg = %b, enable = %b",
//                 $time, PC_new, which, seg, enable);
//    end

endmodule