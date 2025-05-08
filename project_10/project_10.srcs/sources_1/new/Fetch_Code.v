`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/22 11:58:50
// Design Name: 
// Module Name: Fetch_Code
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


module PC_M(
    input clk, rst,
    output reg [31:0] PC,
    output reg [31:0] Inst_code  // ��Ϊ reg ����
);
    wire [31:0] PC_new;
    wire [31:0] rom_data;  // �����м��ź�

    initial PC = 32'h0000_0000;
    assign PC_new = PC + 4;

    InstROM InstROM_ins (
        .clka(clk),
        .addra(PC[7:2]),
        .douta(rom_data)  // ���ӵ��м��ź�
    );

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            PC <= 32'h0000_0000;
            Inst_code <= 32'h0000_0000;  // ��λʱǿ�����ȫ0
        end else begin
            PC <= PC_new;
            Inst_code <= rom_data;  // ��������ʱ����ROM����
        end
    end

    always @(negedge clk) begin
        $display("%d --- %h --- 7_2%d", PC, Inst_code, PC[7:2]);
    end
endmodule