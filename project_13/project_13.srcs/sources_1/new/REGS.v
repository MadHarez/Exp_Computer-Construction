`timescale 1ns / 1ps
module REGS(R_Data_A,R_Data_B,W_Data,R_Addr_A,R_Addr_B,W_Addr,Write_Reg,rst,clk);
	input clk;//写入时钟信号
    input rst;//清零信号
    input Write_Reg;//写控制信号
    
    input [4:0]R_Addr_A;//A端口读寄存器地址
    input [4:0]R_Addr_B;//B端口读寄存器地址
    input [4:0]W_Addr;//写寄存器地址
    
    input [31:0]W_Data;//写入数据
    output [31:0]R_Data_A;//A端口读出数据
    output [31:0]R_Data_B;//B端口读出数据


	 
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
