`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/01 11:10:52
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
    input sw_M_R,
    input sw_PC,
    input sw_ZFOF,
    
    output [31:0]Inst_code,
   
    output wire [2:0] which,   // 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg,     // 段选信号（点亮哪些笔划），低电平有效
    output wire enable          // 使能信号
    );
    
    wire ZF;
    wire OF;
    wire [1:0]PC_s;
    wire [3:0]ALU_OP;
    wire [31:0]B;   //ALU B
    wire [31:0]F;   //ALU_F
    wire [31:0]PC;  //Inst_code执行次数
//机器码
    reg [31:0]display_data;
    
    //寄存器信号声明
    wire Write_Reg; //写入使能信号
    wire [31:0]W_Data; //Input
    wire [4:0]W_Addr;  //input addr
    wire [31:0]R_Data_A;//output
    wire [31:0]R_Data_B;//output
    // R型相关声明
    wire [5:0] op_code; 
    wire [4:0] rs_addr;//R_Addr_A
    wire [4:0] rt_addr;//R_Addr_B
    wire [4:0] rd_addr;
    wire [4:0] shamt;
    wire [5:0] funct;
    // I型相关声明
    wire [15:0]imm;
    wire rd_rt_s;
    wire imm_s;
    wire rt_imm_s;
    wire [31:0]imm_data;
    // J型相关声明
    wire [1:0]w_r_s;
    wire [1:0]wr_data_s;
    wire [25:0]address;
    //存储器信号声明
    wire Mem_Write;
    wire [31:0]M_R_Data;
    reg [31:0] M_W_Data;

    
    PC PC_init(    
    .mclk(mclk),
    .clk(clk),
    .rst(rst),
    .PC_s(PC_s),
    .imm_data(imm_data),
    .address(address),
    .R_Data_A(R_Data_A),
    .PC(PC),
    .Inst_code(Inst_code));
    
    assign op_code = Inst_code[31:26];
    assign rs_addr = Inst_code[25:21];
    assign rt_addr = Inst_code[20:16];
    assign rd_addr = Inst_code[15:11];
    assign shamt = Inst_code[10:6];
    assign funct = Inst_code[5:0];
    assign imm = Inst_code[15:0];
    
    
    OP_Func OP_Func_init(
    .ZF(ZF),
    .clk(clk),
    .op_code(op_code),
    .funct(funct),
    .PC_s(PC_s),
    .Write_Reg(Write_Reg),
    .ALU_OP(ALU_OP),
    .imm_s(imm_s),
    .rt_imm_s(rt_imm_s),
    .wr_data_s(wr_data_s),
    .Mem_Write(Mem_Write),
    .w_r_s(w_r_s)); 
    
    assign W_Addr = (w_r_s[1])?5'b11111:((w_r_s[0])?rt_addr:rd_addr); 
    assign imm_data = imm_s ? {{16{imm[15]}}, imm} : {16'b0, imm};
    
    assign W_Data = (wr_data_s[1])?PC:((wr_data_s[0])? M_R_Data:F);

    REGS_ALU REGS_ALU_init(
    .clk(clk),
    .rst(rst),
    .ALU_OP(ALU_OP),
    .Write_Reg(Write_Reg),
    .rt_imm_s(rt_imm_s),
    .R_Addr_A(rs_addr),
    .R_Addr_B(rt_addr),
    .W_Addr(W_Addr),
    .W_Data(W_Data),
    .imm_data(imm_data),
    .ZF(ZF),
    .OF(OF),
    .F(F),
    .R_Data_A(R_Data_A),
    .R_Data_B(R_Data_B));
    
    RAM RAM_init(
      .clk(mclk), // input clka
      .we(Mem_Write), // input [0 : 0] wea
      .a(F[5:0]), // Mem_Addr
      .d(R_Data_B), // input [31 : 0] dina
      .spo(M_R_Data) // output [31 : 0] douta
      );   

          
    always @(posedge clk) begin
        if (sw_ALU) begin
            display_data = F; // 显示ALU
        end else if (sw_ZFOF) begin
            // 高16位输出ZF，低16位输出OF
            display_data = {ZF, 16'h0} | {16'h0, OF}; // 假设ZF和OF都是16位
            // 或者如果out_ZF_OF是32位，其中高16位是ZF，低16位是OF：
            // display_data = out_ZF_OF; // 直接使用，如果已经是正确的格式
        end else if (sw_M_R) begin
            display_data = M_R_Data; // 显示存储器读出数据
        end else if (sw_PC) begin
            display_data = PC; // 显示写入存储器数据
        end
    end
      
        Display Display_init(
        .clk(clk),
        .which(which),
        .seg(seg),
        .enable(enable),
        .display_data(display_data));
endmodule
