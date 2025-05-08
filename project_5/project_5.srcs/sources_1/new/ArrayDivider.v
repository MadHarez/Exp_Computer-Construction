`timescale 1ns / 1ps  // ����ʵ���������
module ArrayDivider (
    input clk,
    input rst,
    input [10:0] A,    // ��������10��ֵ��
    input [5:0] B,     // ������5��ֵ��
    output reg [5:0] Q, // ��
    output reg [10:0] R  // ����
);

// �ڲ��ź�
reg A_sign, B_sign;
reg [9:0] A_val;      // ��������ֵ���֣�ԭ�룩
reg [4:0] B_val;      // ������ֵ���֣�ԭ�룩
reg [15:0] temp_R;    // ��ʱ��������չλ��
reg [5:0] temp_Q;     // ��ʱ�̣���ֵ���֣�
reg Q_sign;           // �̷���λ
integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Q <= 0;
        R <= 0;
        temp_R <= 0;
        temp_Q <= 0;
        Q_sign <= 0;
    end
    else begin
        // ����1��������ź���ֵ��ԭ��ֱ��ȡ��ֵλ��
        A_sign = A[10];
        B_sign = B[5];
        A_val = A[9:0];  // ԭ����ֵ����
        B_val = B[4:0];   // ԭ����ֵ����
        
        // ����2�������̵ķ���
        Q_sign = A_sign ^ B_sign;
        
        // ����3����ʼ���޷��ų���
        temp_R = A_val;
//        temp_R = A_val << 5;
        temp_Q = 5'b0;
        
        // ����4�����ָ�����������ѭ����ԭ��Ӽ����棩
        for (i = 0; i < 5; i = i + 1) begin  // 5�ε�����������ֵλ����
            temp_R = temp_R << 1;
            
            if( temp_R >= B_val << 5)begin
                temp_R = temp_R - ( B_val << 5 );
                temp_Q = {temp_Q[3:0], 1'b1};
            end 
            else begin                    
                temp_Q = {temp_Q[3:0], 1'b0};
            end

        end
        
        // ����5��������������
        // if (temp_R[15] == 1'b1) begin
        //     temp_R = temp_R + {B_val, 11'b0};
        // end
        if(temp_R >= B_val << 5)begin
            temp_R = temp_R - ( B_val << 5 );
        end

        temp_R = temp_R >> 5;
        
        // ����6����Ͻ��
        Q = {Q_sign, temp_Q[4:0]};  // �̣�����+��ֵ
        R = {A_sign, temp_R[9:0]}; // ���������뱻������ͬ
    end
end


    always @(posedge clk) begin
        $display("A=%b, B=%b, Q=%b, R=%b,Q_TRUE=%b, R_TRUE=%b", A, B, Q, R, A / B, A % B);
    end
endmodule