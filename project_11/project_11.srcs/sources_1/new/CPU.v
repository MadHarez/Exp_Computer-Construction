`timescale 1ns / 1ps

module CPU(
    input mclk,
    input clk,
    input rst,
    input Write_Reg,
    input sw_F_ZFOF,       // 切换显示ALU结果或标志位的开关信号
 
    output reg [31:0] output_signal, // 改为reg类型以便在always块中赋值
    output [2:0] which,     // 数码管位选信号
    output [7:0] seg,       // 数码管段选信号
    output enable       // 数码管使能信号
);
    wire [31:0]Inst_code;// 指令代码输出
    wire [1:0] out_ZF_OF;//标志位输出
    // 内部信号声明
    wire [5:0] op_code;
    wire [4:0] rs_addr;
    wire [4:0] rt_addr;
    wire [4:0] rd_addr;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [31:0] F;          // ALU运算结果

    reg [3:0] ALU_OP;

    // 实例化PC模块
    PC pc1(
        .clk(mclk),
        .rst(rst),
        .Inst_code(Inst_code)
    );
 
    // 指令解码
    assign op_code = Inst_code[31:26];
    assign rs_addr = Inst_code[25:21];
    assign rt_addr = Inst_code[20:16];
    assign rd_addr = Inst_code[15:11];
    assign shamt = Inst_code[10:6];
    assign funct = Inst_code[5:0];
    
    // 实例化REGS_ALU模块
    REGS_ALU regs_alu(
        .clk(clk),          // 连接系统时钟
        .rst(rst),          // 连接复位信号
        .Write_Reg(Write_Reg), // 连接寄存器写使能
        .Inst_code(Inst_code), // 连接指令代码
        .ALU_F(F),         // 输出ALU运算结果
        .which(which),     // 输出数码管位选
        .seg(seg),         // 输出数码管段选
        .enable(enable),   // 输出数码管使能
        .out_ZF_OF(out_ZF_OF) // 输出标志位
    );
       
    // 输出信号选择逻辑 - 同步时序设计
    always @(posedge clk or posedge rst) begin
        if (rst) begin
                output_signal <= 32'b0;  // 复位时清零
        end else begin
            // 根据sw_F_ZFOF选择输出内容
            output_signal <= sw_F_ZFOF ? {30'b0, out_ZF_OF} : F;
        end
    end

endmodule