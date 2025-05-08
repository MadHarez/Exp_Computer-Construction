`timescale 1ns / 1ps
module SignedDivider(
    input clk,
    input [31:0] dividend,
    input [15:0] divisor,
    output [31:0] quotient,
    output [15:0] remainder
);

    div_gen_1 u_div (
        .aclk(clk),
        .s_axis_divisor_tvalid(1'b1),
        .s_axis_divisor_tdata(divisor),
        .s_axis_dividend_tvalid(1'b1),
        .s_axis_dividend_tdata(dividend),
        .m_axis_dout_tvalid(),
        .m_axis_dout_tdata({remainder, quotient})
    );

endmodule