`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 11:28:17 AM
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
    input clk,rst,mclk,
    
    input sw_ALU,
    input sw_ZFOF,
    input sw_M_R,
    input sw_PC,

    output [31:0]Inst_code

    );
    wire [5:0]op_code;
    wire [4:0]rs_addr;
    wire [4:0]rt_addr;
    wire [4:0]rd_addr;
    wire [5:0]shamt;
    wire [5:0]funct;

    reg ZF;
    reg OF;
    reg PC;
    wire [31:0]F;
    reg [31:0]display_data;
    wire [2:0] which;     // �����λѡ�ź�
    wire [7:0] seg;       // ����ܶ�ѡ�ź�
    wire enable;
    
    wire [31:0]Mem_Addr;
    wire [4:0]W_Addr;   
    wire [31:0]imm_data;
    wire [31:0]R_Data_A;
    wire [15:0]imm;
    wire [31:0]ALU_B;
    
   PC PC_init(
   .clk(mclk),
   .rst(rst),
   .Inst_code(Inst_code),
   .PC(PC));
   
    assign op_code = Inst_code[31:26];
    assign rs_addr = Inst_code[25:21];
    assign rt_addr = Inst_code[20:16];
    assign rd_addr = Inst_code[15:11];
    assign shamt = Inst_code[10:6];
    assign funct = Inst_code[5:0];
    assign imm = Inst_code[15:0];
   OP_Func OP_Func_init() 
   
   REGS_ALU REGS_ALU_init(
   .F(F));
   
   
   
    RAM RAM_init(
   .clk(mclk),
   .we(Mem_Write),
   .a(F[5:0]),
   .d(R_Data_B),
   .spo(M_R_Data));  
      
    always @(posedge clk) begin
        if (sw_ALU) begin
            display_data = F; // ��ʾALU
        end else if (sw_ZFOF) begin
            // ��16λ���ZF����16λ���OF
            display_data = {ZF, 16'h0} | {16'h0, OF}; // ����ZF��OF����16λ
            // �������out_ZF_OF��32λ�����и�16λ��ZF����16λ��OF��
            // display_data = out_ZF_OF; // ֱ��ʹ�ã�����Ѿ�����ȷ�ĸ�ʽ
        end else if (sw_M_R) begin
            display_data = M_R_Data; // ��ʾ�洢����������
        end else if (sw_PC  ) begin
            display_data = PC; // ��ʾд��洢������
        end
    end
   Display Display_init(
   .clk(clk),
   .display_data(display_data),
   .which(which),
   .seg(seg)
   );
   
endmodule
