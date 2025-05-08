`timescale 1ns / 1ps
module REGS(R_Data_A,R_Data_B,W_Data,R_Addr_A,R_Addr_B,W_Addr,Write_Reg,rst,clk);
	input clk;//д��ʱ���ź�
    input rst;//�����ź�
    input Write_Reg;//д�����ź�
    
    input [4:0]R_Addr_A;//A�˿ڶ��Ĵ�����ַ
    input [4:0]R_Addr_B;//B�˿ڶ��Ĵ�����ַ
    input [4:0]W_Addr;//д�Ĵ�����ַ
    
    input [31:0]W_Data;//д������
    output [31:0]R_Data_A;//A�˿ڶ�������
    output [31:0]R_Data_B;//B�˿ڶ�������


	 
    integer i=0;
    reg [31:0] REG_Files[0:31];

    initial
        for(i=0;i<32;i=i+1) REG_Files[i]<=0;
        
    always @ (posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    for(i=0;i<=31;i=i+1)
                        REG_Files[i]<=0;
                end
            else
                begin
                    if(Write_Reg)
                        REG_Files[W_Addr]<=W_Data;
                end
        end
        assign R_Data_A = REG_Files[R_Addr_A];
        assign R_Data_B = REG_Files[R_Addr_B];
        
endmodule
