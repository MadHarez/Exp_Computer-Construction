`timescale 1ns / 1ps

module PC(
    input clk,
    input mclk,
    input rst,
    input [1:0] PC_s,
    input [31:0] R_Data_A,
    input [25:0] address,
    input [31:0] imm_data,
    
    output reg [31:0] Inst_code,
    output reg [31:0] PC
);
    // 内部信号声明
    wire [31:0] rom_data;  // ROM输出数据
    wire [31:0]PC_new;
    // PC初始化
    initial begin
        PC = 32'h0000_0000;
        Inst_code = 32'h0000_0000;
    end

    // PC+4计算
    assign PC_new = PC + 4;

    // 指令ROM实例化
    Inst_ROM rom(
        .clka(clk),
        .addra(PC[7:2]),
        .douta(rom_data)  // 连接到中间信号
    );

    // 主时序逻辑
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            PC <= 32'h0000_0000;
            Inst_code <= 32'h0000_0000;  // 复位时清零
        end else begin
            case (PC_s)
                2'b00: PC <= PC_new;
                2'b01: PC <= R_Data_A;
                2'b10: PC <= PC_new + (imm_data << 2);
                2'b11: PC <= {PC_new[31:28], address, 2'b00};
            endcase
            
            // 正常工作时更新指令
            Inst_code <= rom_data;
        end
    end
endmodule