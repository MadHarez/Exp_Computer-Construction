`timescale 1ns / 1ps
module Display(clk,quotient,remainder,seg,digit,count,leds,which,toggle_input,enable,array_Q,array_R,rst);
    input clk,rst;                  // Clock input
    input [31:0] quotient;     // 32-bit quotient input �������
    input [15:0] remainder;   // 16-bit remainder input ���
    input toggle_input;           // 0Ϊ��ʾ����1Ϊ��ʾ�����
    input [5:0] array_Q;
    input [10:0] array_R;
    output reg [31:0] leds = 0;     // 32 LED outputs for quotient
    output reg [7:0] seg;      // 7-segment display segments
    output reg [3:0] digit;
    output reg [2:0] count = 0;
    output reg [2:0] which = 0; // Ƭѡ���루������һλ����ܣ����͵�ƽ��Ч
    output reg enable; //�����ʹ���ź�
        
always @(posedge clk) count <= count + 1'b1; 
always @(negedge clk) if (&count) which <= which + 1'b1; 
always @(*) 
    case (which)
         0: digit <= quotient[31:28]; // ���λ
         1: digit <= quotient[27:24];
         2: digit <= quotient[23:20];
         3: digit <= quotient[19:16];
         4: digit <= quotient[15:12];
         5: digit <= quotient[11:08];
         6: digit <= quotient[07:04];
         7: digit <= quotient[03:0]; // ���λ
 endcase
//�����ԭ�������������� 8.4.2 С�ڣ�HDU-XL-01 �忨�ϵ�����ܲ��ù�������ʽ��
//��˶�ѡΪ 0 ʱ���������
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


always @(posedge clk) begin
    enable = toggle_input; 
    if(toggle_input)begin
        //��ʾip��
         leds <= { 16'h0 , remainder };  // ��16λ=remainder����16λ=0
    end
    else begin
        leds <= {
            array_Q[5:0],  // led[31:26] = array_Q (6 bits)
            10'b0,         // led[25:16] = 0 (10 bits)
            array_R[10:0], // led[15:4] = array_R (12 bits)
            4'b0           // led[3:0] = 0 (4 bits)
        };
    end
//    $display("%b",leds);
end

endmodule