`timescale 1ns / 1ps

module Divider_tb;

    // �����ź�
    reg clk = 0;
    reg rst = 1;
    reg [31:0] input_data;
    reg input_A;
    reg input_B;
    reg sel_meth = 0;  // 0=���г�������1=IP��
    reg sel_sign = 0;   // 0=�޷��ţ�1=�з���

    // ����ź�
    wire [7:0] seg;
    wire enable;
    wire [31:0] leds;
    
    // ʱ�����ɣ�100MHz��
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns ���ڵ�ʱ��
    end
    
    // ʵ�����������
    Divider uut (
        .clk(clk),
        .rst(rst),
        .input_data(input_data),
        .input_A(input_A),
        .input_B(input_B),
        .sel_meth(sel_meth),
        .sel_sign(sel_sign),
        .seg(seg),
        .enable(enable),
        .leds(leds)
    );
    
    // ����������������ֵ
    task set_input;
        input [31:0] a_val;
        input [31:0] b_val;
        begin
            // ����Aֵ
            input_data = a_val;
            input_A = 1;
            #10;
            input_A = 0;
            #10;
            
            // ����Bֵ
            input_data = b_val;
            input_B = 1;
            #10;
            input_B = 0;
            #10;
        end
    endtask
    
    // ����������
    initial begin
        // ��ʼ��
        #20;
        rst = 0;
        #20;
        
//        $display("=== ��ʼ�������г��������з��ţ�===");
        sel_meth = 1;
        sel_sign = 1;
        
        // ��������1��12 / 3 = 4...0
        // ��������1��24 / -31
//        set_input(32'b00000011000,32'b111111);
        // ��������2��-24 / -31
//        set_input(32'b00000011000,32'b011111);
//        set_input(32'b110100000,32'b1011);
//        set_input(32'd12,32'd3);
//        #100;
        set_input(32'b1011,32'b0100);
//        #100;
//        // ��������2��15 / 4 = 3...3
//        set_input(32'd15, 32'd4);
        
//        // ��������3��8 / 5 = 1...3
//        set_input(32'd8, 32'd5);
        
        $display("\n=== ��ʼ����ip�˳��������з��ţ�===");
//        sel_meth = 1;
//        sel_sign = 1;
//        set_input(32'b00000011000,32'b011111);
//        // ��������4��-12 / 3 = -4...0
//        set_input(-32'd12, 32'd3);
        
//        // ��������5��15 / -4 = -3...3
//        set_input(32'd15, -32'd4);
        
//        $display("\n=== ��ʼ����IP�˳��������޷��ţ�===");
//        sel_meth = 1;
//        sel_sign = 0;
        
//        // ��������6��123456 / 256 = 482...64
//        set_input(32'd123456, 32'd256);
        
//        // ��������7��65535 / 256 = 255...255
//        set_input(32'd65535, 32'd256);
        
//        $display("\n=== ��ʼ����IP�˳��������з��ţ�===");
//        sel_sign = 1;
        
//        // ��������8��-123456 / 256 = -482...-64
//        set_input(-32'd123456, 32'd256);
        
//        // ��������9��32767 / -128 = -255...127
//        set_input(32'd32767, -32'd128);
        
//        // ��������10��������
//        $display("\n=== ���Գ����� ===");
//        set_input(32'd100, 32'd0);
//        #100;
//        if (uut.ip_inst.ip_error !== 1'b1) begin
//            $display("[ERROR] Divide by zero detection failed");
//        end else begin
//            $display("[PASS] Divide by zero detected correctly");
//        end
        
//        // ��������11����ʾ�л�����
//        $display("\n=== ������ʾ�л� ===");
//        sel_meth = 0;
//        set_input(32'd123, 32'd45);
//        #100;
//        sel_meth = 1;
//        #100;
        
//        $display("\n=== ���в������ ===");
//        $finish;
    end
    
//    // ���μ�¼
//    initial begin
//        $dumpfile("divider_wave.vcd");
//        $dumpvars(0, Divider_tb);
//    end
endmodule