`timescale 1ns / 1ps

module Multiplier_tb();

// �����ź�
reg [31:0] sw;
reg key1, key2, sel_ip, clk, rst;

// ����ź�
wire [31:0] led;
wire [7:0] seg;
wire [2:0] which;

// ʵ��������ģ��
Multiplier uut (
    .sw(sw),
    .key1(key1),
    .key2(key2),
    .sel_ip(sel_ip),
    .clk(clk),
    .rst(rst),
    .led(led),
    .seg(seg),
    .which(which)
);

// ʱ�����ɣ����� 10ns��
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// ��ʼ������
initial begin
    // ��ʼ״̬
    sw = 32'h0;
    key1 = 0;
    key2 = 0;
    sel_ip = 0;
    rst = 1;  // ��ʼ��λ

    // �ͷŸ�λ
    #20 rst = 0;

    // �����޷��ų˷� (sel_ip=0)
    // ���� A=3, B=5
    sw = 32'h0000_0003;
    #10 key1 = 1;  // ����A
    #10 key1 = 0;
    sw = 32'h0000_0005;
    #10 key2 = 1;  // ����B
    #10 key2 = 0;
    #20;  // �ȴ��������
    // Ԥ�ڽ����product = 15 (0x0000_000F), led=0x0000_0000

    // �����з��ų˷� (sel_ip=1)
    sel_ip = 1;
    // ���� A=-3 (0xFFFF_FFFD), B=5
    sw = 32'hFFFF_FFFD;
    #10 key1 = 1;  // ����A
    #10 key1 = 0;
    sw = 32'h0000_0005;
    #10 key2 = 1;  // ����B
    #10 key2 = 0;
    #20;  // �ȴ��������
    // Ԥ�ڽ����product = -15 (0xFFFF_FFF1), led=0xFFFF_FFFF

    // ���Ը�λ
    #10 rst = 1;
    #10 rst = 0;
    // Ԥ�ڽ����A_reg=0, B_reg=0, product=0

    // ��������
    #100 $finish;
end

// ��ӡ������
always @(posedge clk) begin
    $display("Time=%0t: sel_ip=%b, A=0x%h, B=0x%h, product=0x%h_%h, led=0x%h",
        $time, sel_ip, uut.A_reg, uut.B_reg, uut.product[63:32], uut.product[31:0], led);
end

endmodule