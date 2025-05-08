`timescale 1ns / 1ps

module ALU (
    input wire clk,          // ʱ���ź�
    input wire rst_n,        // ��λ�źţ��͵�ƽ��Ч
    input wire key1,         // ����1���������������A
    input wire key2,         // ����2���������������B
    input wire key3,         // ����3����������ALU_OP
    input wire key4,         // ����4����ʾ��ǰ������ A
    input wire key5,         // ����5����ʾ��ǰ������ B
    input wire key6,         // ����6����ʾ������ F
    input wire [31:0] input_data, // 32λ�������ݣ���������A
    output wire ZF,          // Fȫ0Ϊ1������Ϊ0
    output wire OF,          // ���Ϊ1������Ϊ0
    output wire [2:0] which, // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output wire [7:0] seg,   // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg enable        // Ĭ�Ͽ��������
);

    // �ڲ��ź�
    wire [31:0] A;           // 32λ������A
    wire [31:0] B;           // 32λ������B
    wire [31:0] F;           // 32λ������F
    wire [3:0] ALU_OP;       // 4λALU������
    wire [2:0] count;        // ��Ƶɨ�裬��������ѭ������ÿһλ�����
    wire [3:0] digit;        // ��ʾ���ݣ�Ƭѡ�õ�ʮ����������

    initial enable = 1;     // ��ʼ�� enable Ϊ 1

    // ʵ������ģ��
    input_val i_val (
        .clk(clk),
        .rst_n(rst_n),      
        .key1(key1),
        .key2(key2),
        .key3(key3),
        .input_data(input_data),
        .A(A),
        .B(B),
        .ALU_OP(ALU_OP)
    );
    
    op_val o_val(
        .ALU_OP(ALU_OP),
        .A(A),
        .B(B),
        .F(F),
        .ZF(ZF),
        .OF(OF)
    );

    reg [31:0] output_data; // ��ǰ��ʾ������
    always @(*) begin
        if (key4) begin
            output_data = A; // ��ʾA
        end else if (key5) begin
            output_data = B; // ��ʾB
        end else if (key6) begin
            output_data = F; // ��ʾF
        end else begin
            output_data = 32'h0000_0000; // Ĭ����ʾ0
        end
    end

    output_val o_val_display (
        .clk(clk),
        .data(output_data), // ���ݰ���ѡ����ʾ������
        .which(which),
        .seg(seg),
        .count(count),
        .digit(digit)
    );

endmodule