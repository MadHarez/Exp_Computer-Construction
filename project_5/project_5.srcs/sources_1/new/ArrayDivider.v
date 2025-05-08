`timescale 1ns / 1ps  // 根据实际需求调整
module ArrayDivider (
    input clk,
    input rst,
    input [10:0] A,    // 被除数（10数值）
    input [5:0] B,     // 除数（5数值）
    output reg [5:0] Q, // 商
    output reg [10:0] R  // 余数
);

// 内部信号
reg A_sign, B_sign;
reg [9:0] A_val;      // 被除数数值部分（原码）
reg [4:0] B_val;      // 除数数值部分（原码）
reg [15:0] temp_R;    // 临时余数（扩展位宽）
reg [5:0] temp_Q;     // 临时商（数值部分）
reg Q_sign;           // 商符号位
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
        // 步骤1：分离符号和数值（原码直接取数值位）
        A_sign = A[10];
        B_sign = B[5];
        A_val = A[9:0];  // 原码数值部分
        B_val = B[4:0];   // 原码数值部分
        
        // 步骤2：计算商的符号
        Q_sign = A_sign ^ B_sign;
        
        // 步骤3：初始化无符号除法
        temp_R = A_val;
//        temp_R = A_val << 5;
        temp_Q = 5'b0;
        
        // 步骤4：不恢复余数除法主循环（原码加减交替）
        for (i = 0; i < 5; i = i + 1) begin  // 5次迭代（除数数值位数）
            temp_R = temp_R << 1;
            
            if( temp_R >= B_val << 5)begin
                temp_R = temp_R - ( B_val << 5 );
                temp_Q = {temp_Q[3:0], 1'b1};
            end 
            else begin                    
                temp_Q = {temp_Q[3:0], 1'b0};
            end

        end
        
        // 步骤5：最终余数调整
        // if (temp_R[15] == 1'b1) begin
        //     temp_R = temp_R + {B_val, 11'b0};
        // end
        if(temp_R >= B_val << 5)begin
            temp_R = temp_R - ( B_val << 5 );
        end

        temp_R = temp_R >> 5;
        
        // 步骤6：组合结果
        Q = {Q_sign, temp_Q[4:0]};  // 商：符号+数值
        R = {A_sign, temp_R[9:0]}; // 余数符号与被除数相同
    end
end


    always @(posedge clk) begin
        $display("A=%b, B=%b, Q=%b, R=%b,Q_TRUE=%b, R_TRUE=%b", A, B, Q, R, A / B, A % B);
    end
endmodule