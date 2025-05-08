`timescale 1ns / 1ps

module IP_Divider(
    input        clk,
    input        rst,          // 高电平复位
    input        sel_sign,     // 0=无符号, 1=有符号
    input [31:0] A,
    input [15:0] B,
    output reg [31:0] Q,
    output reg [15:0] R,
    output reg   ip_error
);
    // 独立信号声明
    wire [47:0] unsigned_data, signed_data;
    wire        unsigned_valid, signed_valid;
    
    // 同步选择寄存器
    reg         result_sel;
    wire [47:0] selected_data = result_sel ? signed_data : unsigned_data;
    wire        selected_valid = result_sel ? signed_valid : unsigned_valid;

    // 控制信号
    wire ip_valid = (B != 16'b0);
    // 同步处理
    always @(posedge clk) begin
        if (rst) begin
            result_sel <= 0;
            Q <= 0;
            R <= 0;
        end else begin
            result_sel <= sel_sign;
            if (selected_valid) begin
                R <= selected_data[15:0];
                Q <= selected_data[47:16];
            end
        end
    end

    // 错误检测
    always @(*) begin
        ip_error = (B == 16'b0);
    end

    always @(posedge clk) begin
        $display("A=%b, B=%b, Q=%b, R=%b,Q_TRUE=%b, R_TRUE=%b,selected_data=%b", A, B, Q, R, A / B, A % B,selected_data);
    end

    // 无符号除法IP核（2018.3版本）
    div_gen_0 u_unsigned (
        .aclk(clk),
        .s_axis_divisor_tvalid(ip_valid),
        .s_axis_divisor_tdata(B),
        .s_axis_dividend_tvalid(ip_valid),
        .s_axis_dividend_tdata(A),
        .m_axis_dout_tvalid(unsigned_valid),
        .m_axis_dout_tdata(unsigned_data)
    );

    // 有符号除法IP核（2018.3版本）
    div_gen_1 u_signed (
        .aclk(clk),
        .s_axis_divisor_tvalid(ip_valid),
        .s_axis_divisor_tdata(B),
        .s_axis_dividend_tvalid(ip_valid),
        .s_axis_dividend_tdata(A),
        .m_axis_dout_tvalid(signed_valid),
        .m_axis_dout_tdata(signed_data)
    );
endmodule