`timescale 1ns / 1ps
module REGS(R_Data_A,R_Data_B,W_Data,R_Addr_A,R_Addr_B,W_Addr,Write_Reg,rst,clk,Inst_code);
	input clk;//д��ʱ���ź�
    input rst;//�����ź�
    input Write_Reg;//д�����ź�
    input [4:0]R_Addr_A;//A�˿ڶ��Ĵ�����ַ
    input [4:0]R_Addr_B;//B�˿ڶ��Ĵ�����ַ
    input [4:0]W_Addr;//д�Ĵ�����ַ
    input [31:0]W_Data;//д������
    input [31:0]Inst_code;
	output [31:0]R_Data_A;//A�˿ڶ�������
    output [31:0]R_Data_B;//B�˿ڶ�������
	 
	integer i;
	reg [31:0] REG_Files[0:31];  
    initial for(i=0;i<32;i=i+1) REG_Files[i]<=0;
//    always@(posedge rst)begin
//        for(i=0;i<32;i=i+1) REG_Files[i]<=0;
//    end
//    always@(posedge Write_Reg)begin
//        REG_Files[W_Addr]<=W_Data;
//    end
//    always@(posedge Write_val_btn)begin
//        REG_Files[W_Addr]<=input_val;
//    end
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
                    if(Write_Reg)
                        REG_Files[W_Addr]<=ALU_F;
                        ALU_OP <= Inst_code[31:26];
                        R_Addr_A <= Inst_code[25:21];
                        R_Addr_B <= Inst_code[20:16];
                        W_Addr <= Inst_code[15:11];
                end
        end
        assign R_Data_A = REG_Files[R_Addr_A];
        assign R_Data_B = REG_Files[R_Addr_B];
endmodule
