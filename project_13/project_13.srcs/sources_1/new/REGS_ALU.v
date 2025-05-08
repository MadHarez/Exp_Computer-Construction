module REGS_ALU(
    input clk, rst,
    input Write_Reg,
    input rt_imm_s,
    input [4:0] R_Addr_A,
    input [4:0] R_Addr_B,
    input [4:0] W_Addr,
    input [31:0] W_Data,
    input [3:0] ALU_OP,
    input [31:0] imm_data,

    output ZF,
    output OF,
    output [31:0] F,
    output [31:0] R_Data_B,
    output [31:0] R_Data_A
);
    wire [31:0] B;
      // 用于接收 ALU 的输出

    REGS REGS_init(
        .clk(clk),
        .rst(rst),
        .Write_Reg(Write_Reg),
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),    
        .W_Addr(W_Addr),
        .W_Data(W_Data),
        .R_Data_A(R_Data_A),
        .R_Data_B(R_Data_B)
    );

    assign B = (rt_imm_s) ? imm_data : R_Data_B;

    ALU ALU_init(
        .clk(clk),
        .ALU_OP(ALU_OP),
        .A(R_Data_A),
        .B(B),
        .F(F),  // 将 ALU 的输出连接到 ALU_F
        .ZF(ZF),
        .OF(OF)
    );

endmodule