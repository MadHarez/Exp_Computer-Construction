`timescale 1ns / 1ps

module REGS_ALU(
    input clk, rst, // �����ź�
    input Write_Reg,
    
    input [31:0]Inst_code,
   
    output wire [31:0] ALU_F,   // ALU������
    output wire [2:0] which,   // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output wire [7:0] seg,     // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg enable,       // �������ʾ
    output reg [1:0] out_ZF_OF       // ZF��OF�����
);
    integer i =0;
    reg [31:0] REG_Files[0:31];
    // �ڲ��ź�
    wire [31:0] R_Data_A;      // A�˿ڶ�������
    wire [31:0] R_Data_B;      // B�˿ڶ�������

    wire ZF;                   // ���־
    wire OF;                   // �����־
    wire [2:0] count;         // ��Ƶɨ�裬��������ѭ������ÿһλ�����
    wire [3:0] digit;          // ��ʾ���ݣ�Ƭѡ�õ�ʮ����������
    wire [5:0]funct;

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
    always @ (posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    W_Addr <= 0;   
                    ALU_OP <= 0;   
                    R_Addr_A <= 0; 
                    R_Addr_B <= 0;
                    for(i=0;i<=31;i=i+1)
                        REG_Files[i]<=0;
                end
            else
                begin
                    if(Write_Reg) begin
                        REG_Files[W_Addr]<=ALU_F;
//                        ALU_OP <= Inst_code[31:26];
                        R_Addr_A <= Inst_code[25:21];
                        R_Addr_B <= Inst_code[20:16];
                        W_Addr <= Inst_code[15:11];
                        out_ZF_OF[0] = ZF;
                        out_ZF_OF[1] = OF;
                        begin 
                            case(Inst_code[5:0])
                                6'b100000:ALU_OP=3'b0100;
                                6'b100010:ALU_OP=3'b0101;
                                6'b100100:ALU_OP=3'b0000;
                                6'b100101:ALU_OP=3'b0001;
                                6'b100110:ALU_OP=3'b0010;
                                6'b100111:ALU_OP=3'b0011;
                                6'b101011:ALU_OP=3'b0110;
                                6'b000100:ALU_OP=3'b0111;
                            endcase 
                        end
                    end
                end
        end
        assign R_Data_A = REG_Files[R_Addr_A];
        assign R_Data_B = REG_Files[R_Addr_B];



    // ʵ����ALUģ��
    ALU ALU_1(
        .ALU_OP(ALU_OP),
        .A(R_Data_A),
        .B(R_Data_B),
        .F(ALU_F),
        .ZF(ZF),
        .OF(OF),
        .clk(clk)
    );


    // ʵ�����������ʾģ��
    output_val o_val_display (
        .clk(clk),
        .Inst_code(Inst_code), // ���ݰ���ѡ����ʾ������
        .which(which),
        .seg(seg),
        .count(count),
        .digit(digit)
    );

endmodule