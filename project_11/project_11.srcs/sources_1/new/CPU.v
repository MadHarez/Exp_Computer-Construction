`timescale 1ns / 1ps

module CPU(
    input mclk,
    input clk,
    input rst,
    input Write_Reg,
    input sw_F_ZFOF,       // �л���ʾALU������־λ�Ŀ����ź�
 
    output reg [31:0] output_signal, // ��Ϊreg�����Ա���always���и�ֵ
    output [2:0] which,     // �����λѡ�ź�
    output [7:0] seg,       // ����ܶ�ѡ�ź�
    output enable       // �����ʹ���ź�
);
    wire [31:0]Inst_code;// ָ��������
    wire [1:0] out_ZF_OF;//��־λ���
    // �ڲ��ź�����
    wire [5:0] op_code;
    wire [4:0] rs_addr;
    wire [4:0] rt_addr;
    wire [4:0] rd_addr;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [31:0] F;          // ALU������

    reg [3:0] ALU_OP;

    // ʵ����PCģ��
    PC pc1(
        .clk(mclk),
        .rst(rst),
        .Inst_code(Inst_code)
    );
 
    // ָ�����
    assign op_code = Inst_code[31:26];
    assign rs_addr = Inst_code[25:21];
    assign rt_addr = Inst_code[20:16];
    assign rd_addr = Inst_code[15:11];
    assign shamt = Inst_code[10:6];
    assign funct = Inst_code[5:0];
    
    // ʵ����REGS_ALUģ��
    REGS_ALU regs_alu(
        .clk(clk),          // ����ϵͳʱ��
        .rst(rst),          // ���Ӹ�λ�ź�
        .Write_Reg(Write_Reg), // ���ӼĴ���дʹ��
        .Inst_code(Inst_code), // ����ָ�����
        .ALU_F(F),         // ���ALU������
        .which(which),     // ��������λѡ
        .seg(seg),         // �������ܶ�ѡ
        .enable(enable),   // ��������ʹ��
        .out_ZF_OF(out_ZF_OF) // �����־λ
    );
       
    // ����ź�ѡ���߼� - ͬ��ʱ�����
    always @(posedge clk or posedge rst) begin
        if (rst) begin
                output_signal <= 32'b0;  // ��λʱ����
        end else begin
            // ����sw_F_ZFOFѡ���������
            output_signal <= sw_F_ZFOF ? {30'b0, out_ZF_OF} : F;
        end
    end

endmodule