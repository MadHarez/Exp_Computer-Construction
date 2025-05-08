`timescale 1ns / 1ps
// 8 λ�߶������ɨ����ʾģ�� + LED���
module Display(
    input clk,           // ����ϵͳʱ��
    input [63:0] data,   // 64λ�������ݣ���32λ��LED����32λ������ܣ�
    output reg [31:0] led_out, // 32λLED�������ʾ��32λ��
    output reg [2:0] which = 0, // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output reg [7:0] seg,      // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg [14:0] count = 0, // ��Ƶɨ�裬��������ѭ������ÿһλ�����
    output reg [3:0] digit      // ��ʾ���� Ƭѡ�õ� ʮ����������
);

// ����32λֱ�������LED
always @(*) begin
    led_out = data[63:32];
end

// �����ɨ���߼�
always @(posedge clk) count <= count + 1'b1; 
always @(negedge clk) if (&count) which <= which + 1'b1; 

// �ӵ�32λ��ѡ��ǰҪ��ʾ������
always @(*) 
    case (which)
         0: digit <= data[31:28]; // ���λ
         1: digit <= data[27:24];
         2: digit <= data[23:20];
         3: digit <= data[19:16];
         4: digit <= data[15:12];
         5: digit <= data[11:08];
         6: digit <= data[07:04];
         7: digit <= data[03:0]; // ���λ
    endcase

// ����������߼�
always @(*)
  case (digit) // ʮ���������� ת��Ϊ ��ѡ�źţ�ca,cb,cc,...cg,dp��
     4'h0: seg <= 8'b0000_0011; // �� g��dp ��ȫ������ʾ���� 0
     4'h1: seg <= 8'b1001_1111; // �� b��c ������ʾ���� 1
     4'h2: seg <= 8'b0010_0101; 
     4'h3: seg <= 8'b0000_1101; 
     4'h4: seg <= 8'b1001_1001; 
     4'h5: seg <= 8'b0100_1001; 
     4'h6: seg <= 8'b0100_0001; 
     4'h7: seg <= 8'b0001_1111; 
     4'h8: seg <= 8'b0000_0001; 
     4'h9: seg <= 8'b0000_1001; 
     4'hA: seg <= 8'b0001_0001; 
     4'hB: seg <= 8'b1100_0001; 
     4'hC: seg <= 8'b0110_0011; 
     4'hD: seg <= 8'b1000_0101; 
     4'hE: seg <= 8'b0110_0001; 
     4'hF: seg <= 8'b0111_0001; 
  endcase
endmodule