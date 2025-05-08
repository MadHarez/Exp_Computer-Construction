`timescale 1ns / 1ps
module RAM(
    input [31:0] input_val,
    input [1:0]keys, // 0Ϊ����Mem_Addr ,1Ϊд��M_W_Data
    input clk,
    input rst, 
    input Mem_Write,                // дʹ���ź�
    output reg [5:0] addr_led,  // 6λLED����ʾ��ǰ�洢����ַ
    output wire [2:0] which, // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output wire [7:0] seg, // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg enable //Ĭ�Ͽ��������
);
initial enable = 1; // ��ʼ�� enable Ϊ 1

wire [31:0] M_R_Data; // 8Ƭ�������ʾ�����Ĵ洢������
wire [3:0] digit; // ��ʾ���� Ƭѡ�õ� ʮ����������
wire [2:0] count; // ��Ƶɨ�裬��������ѭ������ÿһλ�����
reg [7:2] Mem_Addr;             // �洢����ַ
reg [31:0] M_W_Data;            // �洢������
RAM_B your_instance_name (
  .clka(clk), // input clka
  .wea(Mem_Write), // input [0 : 0] wea
  .addra(Mem_Addr), // input [5 : 0] addra
  .dina(M_W_Data), // input [31 : 0] dina
  .douta(M_R_Data) // output [31 : 0] douta
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Mem_Addr <= 6'b0;
        M_W_Data <= 32'b0;
        addr_led <= 6'b0;
    end else begin
        if (keys[0]) begin
            Mem_Addr <= input_val[7:2];  // д���ַ
        end else if (keys[1]) begin
            M_W_Data <= input_val;  // д������
        end
        // ��ʾ��ǰ��ַ
        addr_led <= Mem_Addr;
    end
end


    output_val o_val_display (
    .clk(clk),
    .data(M_R_Data), // ���ݰ���ѡ����ʾ������
    .which(which),
    .seg(seg),
    .count(count),
    .digit(digit)
);

endmodule
