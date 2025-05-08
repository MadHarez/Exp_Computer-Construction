`timescale 1ns / 1ps

//keys0~3，0显示a 1显示b 2显示f 3显示ZFOF
module REGS_ALU(
    input clk, rst, Write_Reg, // 控制信号
    input key1,          // 显示a
    input key2,          // 显示b
    input key3,          // 显示f
    input key4,          // 显示ZFOF
    input Write_T,             // 新增按钮，用于暂存 W_Addr, ALU_OP, R_Addr_A, R_Addr_B
    input Write_val_btn,       // 输入数据按钮
    input [31:0] input_all,    // 全部数据输入
    output wire [2:0] which,   // 片选编码（驱动哪一位数码管），低电平有效
    output wire [7:0] seg,     // 段选信号（点亮哪些笔划），低电平有效
    output reg enable,       // 数码管显示
    output reg [1:0] out_ZF_OF       // ZF和OF的输出
);

    // 内部信号
    wire [31:0] R_Data_A;      // A端口读出数据
    wire [31:0] R_Data_B;      // B端口读出数据
    wire [31:0] ALU_F;         // ALU运算结果
    wire ZF;                   // 零标志
    wire OF;                   // 溢出标志
    wire [10:0] count;         // 分频扫描，从左至右循环驱动每一位数码管
    wire [3:0] digit;          // 显示数据，片选得到十六进制数码

    // 新增寄存器用于暂存 W_Addr, ALU_OP, R_Addr_A, R_Addr_B
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

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            W_Addr <= 0;
            ALU_OP <= 0;
            R_Addr_A <= 0;
            R_Addr_B <= 0;
            input_val <= 0;
        end else if (Write_T) begin
            W_Addr <= input_all[4:0];
            ALU_OP <= input_all[15:12];
            R_Addr_A <= input_all[20:16];
            R_Addr_B <= input_all[31:27];
//            W_Addr <= {input_all[0], input_all[1], input_all[2], input_all[3], input_all[4]};
//            ALU_OP <= {input_all[12], input_all[13], input_all[14], input_all[15]};
//            R_Addr_A <= {input_all[16], input_all[17], input_all[18], input_all[19], input_all[20]};
//            R_Addr_B <= {input_all[27], input_all[28], input_all[29], input_all[30], input_all[31]};
        end else if (Write_val_btn) begin
            input_val <= input_all[31:0];
        end
    end

    // 实例化寄存器模块
    REGS REGS_1(
        .R_Data_A(R_Data_A),
        .R_Data_B(R_Data_B),
        .W_Data(ALU_F),
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),
        .W_Addr(W_Addr),
        .Write_Reg(Write_Reg),
        .rst(rst),
        .clk(clk),
        .input_val(input_val),
        .Write_val_btn(Write_val_btn)
    );

    // 实例化ALU模块
    ALU ALU_1(
        .ALU_OP(ALU_OP),
        .A(R_Data_A),
        .B(R_Data_B),
        .F(ALU_F),
        .ZF(ZF),
        .OF(OF)
    );

    // 显示逻辑
    reg [31:0] output_data; // 当前显示的数据
    always @(*) begin
        if (key1) begin
            output_data = R_Data_A; // 显示A
        end else if (key2) begin
            output_data = R_Data_B; // 显示B
        end else if (key3) begin
            output_data = ALU_F; // 显示F
        end else begin
            output_data = 32'h0000_0000; // 默认显示0
        end
        if (key4) begin
            out_ZF_OF[0] = ZF;
            out_ZF_OF[1] = OF;
        end else begin
            out_ZF_OF[0] = 0;
            out_ZF_OF[1] = 0;
        end
    end

    // 实例化数码管显示模块
    output_val o_val_display (
        .clk(clk),
        .data(output_data), // 根据按键选择显示的数据
        .which(which),
        .seg(seg),
        .count(count),
        .digit(digit)
    );

endmodule