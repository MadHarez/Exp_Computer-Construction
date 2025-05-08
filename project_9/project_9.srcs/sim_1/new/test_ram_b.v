`timescale 1ns / 1ps

module MIPS_tb;

    // ����ʱ���ź�
    reg clk;
    // �����ַ�ź�
    reg [9:0] addr;
    // �����������
    wire [31:0] data_out;

    // ʵ��������ģ��
    MIPS mips_ins (
        .clk(clk),
        .addr(addr),
        .data_out(data_out)
    );

    // ��ʼ��ʱ���ź�
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // ����50MHz��ʱ���ź�
    end

    // ���Թ���
    initial begin
        // ��ʼ����ַ
        addr = 0;
        #10;

        // ������ȡָ��洢���е�ָ��
        repeat (14) begin
            #10;
            addr = addr + 1;
            $display("Address: %d, Data: %h", addr, data_out);
        end

        // ��������
        #10;
        $finish;
    end

endmodule