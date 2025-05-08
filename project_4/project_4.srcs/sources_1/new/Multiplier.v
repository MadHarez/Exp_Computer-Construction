module Multiplier(
    input [32:1] sw,       // 32λ��������
    input wire key1,         // ����1���������������A R4
    input wire key2,         // ����2���������������B AB6
    input sel_ip,          // IP��ѡ�񰴼� V8
    input clk,             // ʱ�Ӱ��� 
    input rst,             // ��λ���� V9
    output [31:0] led,     // �˻���32λ
    output [7:0] seg,      // ����ܶ�ѡ
    output [2:0] which,    // �����λѡ
    output reg enable
);

initial enable = 1;
reg [31:0] A_reg, B_reg;
wire [63:0] P_unsigned, P_signed, product;

always @(posedge clk or posedge rst) begin
    if (rst) begin          // ��λʱ���� A �� B
        A_reg <= 32'b0;
        B_reg <= 32'b0;
    end
    else begin
        if (key1)           // ����1����ʱ������A
            A_reg <= sw;
        if (key2)           // ����2����ʱ������B
            B_reg <= sw;
    end
end


// ʵ�����˷���IP��
unsign_multiplier u_unsign_multiplier_1 (
    .CLK(clk),
    .A(A_reg),
    .B(B_reg),
    .P(P_unsigned)
);

sign_multiplier u_sign_multiplier (
    .CLK(clk),
    .A(A_reg),
    .B(B_reg),
    .P(P_signed)
);

// ���ѡ��
assign product = sel_ip ? P_signed : P_unsigned;
assign led = product[63:32];  // LED��ʾ��32λ

// ʵ�����������ʾģ��
Display u_Display (
    .clk(clk),
    .data(product[31:0]),  // �������ʾ��32λ
    .seg(seg),
    .which(which)
);

endmodule