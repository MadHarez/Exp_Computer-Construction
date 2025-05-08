`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/29 17:42:20
// Design Name: 
// Module Name: CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


    module CPU(
    input clk,
    input mclk,
    input rst,
    
    input sw_ALU,
    input sw_ZFOF,
    input sw_M_R,
    input sw_W_Data,
    
    output [2:0] which,     // �����λѡ�ź�
    output [7:0] seg,       // ����ܶ�ѡ�ź�
    output enable, // �����ʹ���ź�
    
    output [31:0]Inst_code

    );
    
    wire [1:0] out_ZF_OF;//��־λ���
    // �ڲ��ź�����
    wire [5:0] op_code;
    wire [4:0] rs_addr;
    wire [4:0] rt_addr;
    wire [4:0] rd_addr;
    wire [4:0] shamt;
    wire [5:0] funct;
    
    wire [31:0]Mem_Addr;
    wire [4:0]W_Addr;   
    wire [15:0]imm_data;
    wire [31:0]R_Data_A;
    wire [15:0]imm;
    wire [31:0]ALU_B;
    
    wire Write_Reg;
    wire rd_rt_s;     
    wire imm_s;         
    wire rt_imm_s;     
    wire Mem_Write;    
    wire alu_mem_s;     
    wire [31:0] R_Data_B;
    
    wire OF,ZF;
    wire [31:0]F; // ALU������
    wire [31:0]M_R_Data;
    wire [31:0]W_Data;
  

    wire [3:0] ALU_OP;
    
    reg [31:0] display_data;
    
 
    assign op_code = Inst_code[31:26];
    assign rs_addr = Inst_code[25:21];
    assign rt_addr = Inst_code[20:16];
    assign rd_addr = Inst_code[15:11];
    assign shamt = Inst_code[10:6];
    assign funct = Inst_code[5:0];
    assign imm = Inst_code[15:0];
    
    assign W_Addr = (rd_rt_s)?rt_addr:rd_addr;
    assign imm_data = imm_s ? {{16{imm[15]}}, imm} : {16'b0, imm};
    assign W_Data = alu_mem_s?M_R_Data:F;

             //ʵ����OP_Funcģ��
    OP_Func OP_Func_init(
    .op_code(op_code),
    .funct(funct),
    .Write_Reg(Write_Reg),
    .ALU_OP(ALU_OP),
    .rd_rt_s(rd_rt_s),
    .imm_s(imm_s),
    .rt_imm_s(rt_imm_s),
    .Mem_Write(Mem_Write),
    .alu_mem_s(alu_mem_s),
    .clk(clk)
    );
            //ʵ����PCģ��
    PC PC_init(
    .clk(clk),
    .mclk(mclk),
    .rst(rst),
    .Inst_code(Inst_code));
    
    RAM RAM_init(
        .clk(mclk), // input clka
        .we(Mem_Write), // input [0 : 0] wea
        .a(F[5:0]), // input [5 : 0] addra
        .d(R_Data_B), // input [31 : 0] dina
        .spo(M_R_Data) // output [31 : 0] douta
    );
    

        // ʵ����REGS_ALUģ��
    REGS_ALU regs_alu(
        .clk(clk),          // ����ϵͳʱ��
        .rst(rst),          // ���Ӹ�λ�ź�
        .Write_Reg(Write_Reg),// ���ӼĴ���дʹ��
        .Inst_code(Inst_code), // ����ָ�����
        .rt_imm_s(rt_imm_s),
        .imm_s(imm_s),
        .imm_data(imm_data),
        .M_R_Data(M_R_Data),
        .W_Data(W_Data),
        .ALU_F(F),         // ���ALU������
        .which(which),     // ��������λѡ
        .seg(seg),         // �������ܶ�ѡ
        .enable(enable),   // ��������ʹ��
        .out_ZF_OF(out_ZF_OF), // �����־λ
        .ALU_OP(ALU_OP)
    );
        always @(posedge clk) begin
        if (sw_ALU) begin
            display_data = F; // ��ʾALU
        end else if (sw_ZFOF) begin
            display_data = out_ZF_OF; // ��ʾZFOF
        end else if (sw_M_R) begin
            display_data = M_R_Data; // ��ʾ�洢����������
        end else if (sw_W_Data) begin
            display_data = W_Data; // ��ʾд��洢������
        end
    end
    // ʵ�����������ʾģ��
    output_val o_val_display (
        .clk(clk),
        .display_data(display_data),
        .which(which),
        .seg(seg)
    );

endmodule
