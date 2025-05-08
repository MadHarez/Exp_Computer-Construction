`timescale 1ns / 1ps

 module REGS_Test;

    // �����ź�
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

    // ����ź�
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // �ڲ��ź�
    wire [31:0] R_Data_A;      // A�˿ڶ�������
    wire [31:0] R_Data_B;      // B�˿ڶ�������
    wire ZF;                   // ���־
    wire OF;                   // �����־
    wire [31:0] ALU_F;         // ALU������
    wire [10:0] count;         // ��Ƶɨ�裬��������ѭ������ÿһλ�����
    wire [3:0] digit;          // ��ʾ���ݣ�Ƭѡ�õ�ʮ����������
    wire [1:0] out_ZF_OF;      // ZF��OF�����

    // ʵ����������ģ��
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

    // ʱ������
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns ����ʱ��
    end

    // ���Թ���
    initial begin
        // ��ʼ���ź�
        rst = 1;
        Write_Reg = 0;
        input_all = 0;
        key1 = 0;
        key2 = 0;
        key3 = 0;
        key4 = 0;
        Write_T = 0;
        Write_val_btn = 0;

        // ��λ
        #20;
        rst = 0;

        // ���� 1: ʹ�� Write_val_btn д���������ݵ�������ͬ�ĵ�ַ
        #10;
        input_all[31:27] = 5'b00010; // R_Addr_B = 2
        input_all[19:16] = 5'b00001; // R_Addr_A = 1
        input_all[15:12] = 4'b0000;  // ALU_OP = 0
        input_all[4:0]   = 5'b00001; // W_Addr = 1
        Write_T = 1; // �ݴ��ַ�Ͳ�����
        #10;
        Write_T = 0;

        // ʹ�� Write_val_btn д���һ�����ݵ���ַ 1
        #10;
        input_all = 32'h1234_5678; // д������ 0x12345678
        Write_val_btn = 1; // ʹ�� input_val д������
        #10;
        Write_val_btn = 0;
        #10;

        // ʹ�� Write_val_btn д��ڶ������ݵ���ַ 2
        input_all[4:0] = 5'b00010; // W_Addr = 2
        Write_T = 1;
        #10;
        Write_T = 0;
        #10;
        input_all = 32'h8765_4321; // д������ 0x87654321
        Write_val_btn = 1; // ʹ�� input_val д������
        #10;
        Write_val_btn = 0;

        // ���� 2: ��ȡ�Ĵ�����ִ�� ALU ����
        #10;
        input_all[31:27] = 5'b00010; // R_Addr_B = 2
        input_all[19:16] = 5'b00001; // R_Addr_A = 1
        input_all[15:12] = 4'b0100;  // ALU_OP = 4 (�ӷ�)
        input_all[4:0]   = 5'b00011; // W_Addr = 3
        Write_T = 1; // �ݴ��ַ�Ͳ�����
        #10;
        Write_T = 0;

        // ִ�� ALU ��������ʾ���
        key4 = 1;
        key3 = 1;
        #500;
        key4 = 0;
        key1 = 0;
        key2 = 0;
        key3 = 0;
        // ���� 3: ʹ�� Write_Reg �� ALU_F д��Ĵ���
        #10;
        Write_Reg = 1; // д��F
        #10;
        Write_Reg = 0;

        // ��ʾд���ļĴ���ֵ
        #10
//        keys = 4'b0001; // ��ʾ A
        key1 = 1;
        #500;
        key4 = 0;
        key1 = 0;
        key2 = 0;
        key3 = 0;
//        keys = 4'b0010; // ��ʾ B        key1 = 1;
        key2 = 1;
        #500;
        
        $stop;
    end
endmodule