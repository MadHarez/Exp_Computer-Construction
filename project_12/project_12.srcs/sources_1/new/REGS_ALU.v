`timescale 1ns / 1ps

module REGS_ALU(
    input clk, rst, // 控制信号
    input Write_Reg,
    
    input [31:0]Inst_code,
    input [31:0] M_R_Data,      // 存储器读出数据（新增）input
    input [31:0] W_Data,
    input [3:0] ALU_OP,
    input [15:0]imm_data,
    input rt_imm_s,
    input imm_s,
    output wire [31:0] ALU_F,   // ALU运算结果
    output wire [2:0] which,   // 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg,     // 段选信号（点亮哪些笔划），低电平有效
    output reg enable,       // 数码管显示
    output reg [1:0] out_ZF_OF    // ZF和OF的输出
    
);
    integer i =0;
    reg [31:0] REG_Files[0:31];
    // 内部信号
    wire [31:0] R_Data_A;      // A端口读出数据
    wire [31:0] R_Data_B;      // B端口读出数据
    wire [31:0] ALU_B;
    wire ZF;                   // 零标志
    wire OF;                   // 溢出标志
    wire [2:0] count;         // 分频扫描，从左至右循环驱动每一位数码管
    wire [3:0] digit;          // 显示数据，片选得到十六进制数码
    wire [5:0]funct;

    // 新增寄存器用于暂存 W_Addr, ALU_OP, R_Addr_A, R_Addr_B
    reg [4:0] W_Addr;
    reg [4:0] R_Addr_A;
    reg [4:0] R_Addr_B;
    reg [31:0] input_val;

    initial begin
        out_ZF_OF = 0;
        enable = 1;
        W_Addr = 0;
        R_Addr_A = 0;
        R_Addr_B = 0;
    end
    always @ (posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    W_Addr <= 0;   
//                    ALU_OP <= 0;   
                    R_Addr_A <= 0; 
                    R_Addr_B <= 0;
                    for(i=0;i<=31;i=i+1)
                        REG_Files[i]<=0;
                end
            else
                begin
                    if(Write_Reg) begin
                        REG_Files[W_Addr]<=ALU_F;
                        R_Addr_A <= Inst_code[25:21];
                        R_Addr_B <= Inst_code[20:16];
                        W_Addr <= Inst_code[15:11];
                        out_ZF_OF[0] = ZF;
                        out_ZF_OF[1] = OF;
                    end
                end
        end
        assign R_Data_A = REG_Files[R_Addr_A];
        assign R_Data_B = REG_Files[R_Addr_B];

    assign ALU_B = (rt_imm_s)?imm_data:R_Data_B;   
    

    // 实例化ALU模块
    ALU ALU_1(
        .ALU_OP(ALU_OP),
        .A(R_Data_A),
        .B(ALU_B),
        .F(ALU_F),
        .ZF(ZF),
        .OF(OF),
        .clk(clk)
    );



endmodule