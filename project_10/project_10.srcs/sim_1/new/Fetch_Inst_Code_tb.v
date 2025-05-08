`timescale 1ns / 1ps

module Fetch_Inst_Code_tb;

    // ���������ź�
    reg clk;
    reg rst;
    reg mclk;
    wire [31:0] PC;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // ʵ����������ģ��
    Fetch_Inst_Code u0(
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .which(which),
        .seg(seg),
        .enable(enable),
        .mclk(mclk)
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
        mclk = 1;
        #10
        mclk = 0;
        #100; // �ȴ�һ��ʱ��۲����
        rst = 1; // ���λ
        #10;
        rst = 0; // �ͷŸ�λ
        #100; // �ȴ�һ��ʱ��۲����
        mclk = 1;
        #10
        mclk = 0;
        #100; // �ȴ�һ��ʱ��۲����
        $finish;
    end

    // ������
//    initial begin
//        $monitor("Time = %0t, PC_new = %h, which = %b, seg = %b, enable = %b",
//                 $time, PC_new, which, seg, enable);
//    end

endmodule