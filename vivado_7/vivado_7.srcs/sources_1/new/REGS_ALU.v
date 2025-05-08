`timescale 1ns / 1ps

//keys0~3��0��ʾa 1��ʾb 2��ʾf 3��ʾZFOF
module REGS_ALU(
    input clk, rst, Write_Reg, // �����ź�
    input key1,          // ��ʾa
    input key2,          // ��ʾb
    input key3,          // ��ʾf
    input key4,          // ��ʾZFOF
    input Write_T,             // ������ť�������ݴ� W_Addr, ALU_OP, R_Addr_A, R_Addr_B
    input Write_val_btn,       // �������ݰ�ť
    input [31:0] input_all,    // ȫ����������
    output wire [2:0] which,   // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output wire [7:0] seg,     // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg enable,       // �������ʾ
    output reg [1:0] out_ZF_OF       // ZF��OF�����
);

    // �ڲ��ź�
    wire [31:0] R_Data_A;      // A�˿ڶ�������
    wire [31:0] R_Data_B;      // B�˿ڶ�������
    wire [31:0] ALU_F;         // ALU������
    wire ZF;                   // ���־
    wire OF;                   // �����־
    wire [10:0] count;         // ��Ƶɨ�裬��������ѭ������ÿһλ�����
    wire [3:0] digit;          // ��ʾ���ݣ�Ƭѡ�õ�ʮ����������

    // �����Ĵ��������ݴ� W_Addr, ALU_OP, R_Addr_A, R_Addr_B
    reg [4:0] W_Addr;
    reg [3:0] ALU_OP;
    reg [4:0] R_Addr_A;
    reg [4:0] R_Addr_B;
    reg [31:0] input_val;

    initial begin
        out_ZF_OF = 0;
        enable = 1;
        W_Addr = 0;
        ALU_OP = 0;
        R_Addr_A = 0;
        R_Addr_B = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            W_Addr <= 0;
            ALU_OP <= 0;
            R_Addr_A <= 0;
            R_Addr_B <= 0;
            input_val <= 0;
        end else if (Write_T) begin
            W_Addr <= input_all[4:0];
            ALU_OP <= input_all[15:12];
            R_Addr_A <= input_all[20:16];
            R_Addr_B <= input_all[31:27];
//            W_Addr <= {input_all[0], input_all[1], input_all[2], input_all[3], input_all[4]};
//            ALU_OP <= {input_all[12], input_all[13], input_all[14], input_all[15]};
//            R_Addr_A <= {input_all[16], input_all[17], input_all[18], input_all[19], input_all[20]};
//            R_Addr_B <= {input_all[27], input_all[28], input_all[29], input_all[30], input_all[31]};
        end else if (Write_val_btn) begin
            input_val <= input_all[31:0];
        end
    end

    // ʵ�����Ĵ���ģ��
    REGS REGS_1(
        .R_Data_A(R_Data_A),
        .R_Data_B(R_Data_B),
        .W_Data(ALU_F),
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),
        .W_Addr(W_Addr),
        .Write_Reg(Write_Reg),
        .rst(rst),
        .clk(clk),
        .input_val(input_val),
        .Write_val_btn(Write_val_btn)
    );

    // ʵ����ALUģ��
    ALU ALU_1(
        .ALU_OP(ALU_OP),
        .A(R_Data_A),
        .B(R_Data_B),
        .F(ALU_F),
        .ZF(ZF),
        .OF(OF)
    );

    // ��ʾ�߼�
    reg [31:0] output_data; // ��ǰ��ʾ������
    always @(*) begin
        if (key1) begin
            output_data = R_Data_A; // ��ʾA
        end else if (key2) begin
            output_data = R_Data_B; // ��ʾB
        end else if (key3) begin
            output_data = ALU_F; // ��ʾF
        end else begin
            output_data = 32'h0000_0000; // Ĭ����ʾ0
        end
        if (key4) begin
            out_ZF_OF[0] = ZF;
            out_ZF_OF[1] = OF;
        end else begin
            out_ZF_OF[0] = 0;
            out_ZF_OF[1] = 0;
        end
    end

    // ʵ�����������ʾģ��
    output_val o_val_display (
        .clk(clk),
        .data(output_data), // ���ݰ���ѡ����ʾ������
        .which(which),
        .seg(seg),
        .count(count),
        .digit(digit)
    );

endmodule