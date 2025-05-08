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
    // �ڲ��ź�����
    wire [31:0] rom_data;  // ROM�������
    wire [31:0]PC_new;
    // PC��ʼ��
    initial begin
        PC = 32'h0000_0000;
        Inst_code = 32'h0000_0000;
    end

    // PC+4����
    assign PC_new = PC + 4;

    // ָ��ROMʵ����
    Inst_ROM rom(
        .clka(clk),
        .addra(PC[7:2]),
        .douta(rom_data)  // ���ӵ��м��ź�
    );

    // ��ʱ���߼�
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            PC <= 32'h0000_0000;
            Inst_code <= 32'h0000_0000;  // ��λʱ����
        end else begin
            case (PC_s)
                2'b00: PC <= PC_new;
                2'b01: PC <= R_Data_A;
                2'b10: PC <= PC_new + (imm_data << 2);
                2'b11: PC <= {PC_new[31:28], address, 2'b00};
            endcase
            
            // ��������ʱ����ָ��
            Inst_code <= rom_data;
        end
    end
endmodule