`timescale 1ns / 1ps
// ͨ����������������Կ��ء�LED������ܣ�ͨ�������ʹ�ܲ��԰���
module Board(sw, swb, led, clk, which, seg, enable);
    input [31:0] sw;
    output [31:0] led;
    assign led = sw; // �����������ݣ�ֱ������� LED
    input clk; // ��������
    output [2:0] which;
    output [7:0] seg;
    output reg enable = 1; // Ĭ�Ͽ��������ʹ��
    Display Display_Instance(
     .clk(clk), 
     .data(sw), 
     .which(which), 
     .seg(seg)
    );
    input [7:0] swb; //ע�⣺1��8 ����Ա��ذ忨�Ĳ�����
    //Զ�̰忨��ֻ�� 6 ��������
    //����������Զ��ʵ��ʱ��Ҫ�޸Ĳ���
    wire toggle;
    assign toggle =|swb; // �������ⰴ���л������ʹ��
    always @(posedge toggle) enable <= ~enable;
endmodule