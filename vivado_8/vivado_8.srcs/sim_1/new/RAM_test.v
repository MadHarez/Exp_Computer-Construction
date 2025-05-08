`timescale 1ns / 1ps

module RAM_test;

    // �����ź�
    reg [31:0] input_val;
    reg [1:0] keys;
    reg clk;
    reg rst;
    reg Mem_Write;

    // ����ź�
    wire [5:0] addr_led;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // ʵ����RAMģ��
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

    // ʱ������
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns���ڵ�ʱ��
    end

    // ���Թ���
    initial begin
        // ��ʼ���ź�
        input_val = 32'h0000_0000;
        keys = 2'b00;
        rst = 1;
        Mem_Write = 0;

        // ��λ
        #20;
        rst = 0;

        // ����1: д���һ��������ַ 6'b000001
        #10;
        input_val = 32'h0000_0004; // ��ַΪ 6'b000001 (1)
        keys = 2'b01; // ѡ��д���ַ
        #10;
        keys = 2'b00; // ȡ��ѡ��

        #10;
        input_val = 32'h1234_5678; // д�������
        keys = 2'b10; // ѡ��д������
        #10;
        keys = 2'b00; // ȡ��ѡ��

        #10;
        Mem_Write = 1; // ʹ��д����
        #10;
        Mem_Write = 0; // ȡ��д����

        // ����2: д��ڶ���������ַ 6'b000010
        #10;
        input_val = 32'h0000_0008; // ��ַΪ 6'b000010 (2)
        keys = 2'b01; // ѡ��д���ַ
        #10;
        keys = 2'b00; // ȡ��ѡ��

        #10;
        input_val = 32'h8765_4321; // д�������
        keys = 2'b10; // ѡ��д������
        #10;
        keys = 2'b00; // ȡ��ѡ��

        #10;
        Mem_Write = 1; // ʹ��д����
        #10;
        Mem_Write = 0; // ȡ��д����

        // ����3: ��ȡ��һ�����ӵ�ַ 6'b000001
        #10;
        input_val = 32'h0000_0004; // ��ַΪ 6'b000001 (1)
        keys = 2'b01; // ѡ��д���ַ
        #10;
        keys = 2'b00; // ȡ��ѡ��

        // ����4: ��ȡ�ڶ������ӵ�ַ 6'b000010
        #10;
        input_val = 32'h0000_0008; // ��ַΪ 6'b000010 (2)
        keys = 2'b01; // ѡ��д���ַ
        #10;
        keys = 2'b00; // ȡ��ѡ��

        // ��������
        #100;
        $stop;
    end

endmodule