`timescale 1ns / 1ps

module output_val(
    input clk,                  // ϵͳʱ��
    input [31:0]display_data,            // ��ʾд��洢������
    output reg [2:0] which = 0, // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output reg [7:0] seg,       // ��ѡ�źţ�������Щ�ʻ������͵�ƽ��Ч
    output reg enable = 1       // �����ʹ���źţ�������
);

    reg [14:0] count = 0;        // ��Ƶ������
    reg [3:0] digit;            // ��ǰ��ʾ��ʮ����������

    // ��Ƶɨ���߼�
    always @(posedge clk) begin
        count <= count + 1'b1;
    end

    // Ƭѡ�߼���ѭ������ÿһλ����ܣ�
    always @(negedge clk) begin
        if (&count) which <= which + 1'b1;
    end


    // Ƭѡ��ǰ����ܶ�Ӧ������λ
    always @(*) begin
        case (which)
            0: digit = display_data[31:28]; // ���λ
            1: digit = display_data[27:24];
            2: digit = display_data[23:20];
            3: digit = display_data[19:16];
            4: digit = display_data[15:12];
            5: digit = display_data[11:8];
            6: digit = display_data[7:4];
            7: digit = display_data[3:0];   // ���λ
        endcase
    end

    // ʮ����������ת��Ϊ��ѡ�źţ�����������ܣ�0 ������
    always @(*) begin
        case (digit)
            4'h0: seg = 8'b0000_0011; // ��ʾ 0
            4'h1: seg = 8'b1001_1111; // ��ʾ 1
            4'h2: seg = 8'b0010_0101; // ��ʾ 2
            4'h3: seg = 8'b0000_1101; // ��ʾ 3
            4'h4: seg = 8'b1001_1001; // ��ʾ 4
            4'h5: seg = 8'b0100_1001; // ��ʾ 5
            4'h6: seg = 8'b0100_0001; // ��ʾ 6
            4'h7: seg = 8'b0001_1111; // ��ʾ 7
            4'h8: seg = 8'b0000_0001; // ��ʾ 8
            4'h9: seg = 8'b0000_1001; // ��ʾ 9
            4'hA: seg = 8'b0001_0001; // ��ʾ A
            4'hB: seg = 8'b1100_0001; // ��ʾ B
            4'hC: seg = 8'b0110_0011; // ��ʾ C
            4'hD: seg = 8'b1000_0101; // ��ʾ D
            4'hE: seg = 8'b0110_0001; // ��ʾ E
            4'hF: seg = 8'b0111_0001; // ��ʾ F
        endcase
    end

endmodule