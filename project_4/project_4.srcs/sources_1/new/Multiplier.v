module Multiplier(
    input [32:1] sw,       // 32位开关输入
    input wire key1,         // 按键1，用于输入操作数A R4
    input wire key2,         // 按键2，用于输入操作数B AB6
    input sel_ip,          // IP核选择按键 V8
    input clk,             // 时钟按键 
    input rst,             // 复位案件 V9
    output [31:0] led,     // 乘积高32位
    output [7:0] seg,      // 数码管段选
    output [2:0] which,    // 数码管位选
    output reg enable
);

initial enable = 1;
reg [31:0] A_reg, B_reg;
wire [63:0] P_unsigned, P_signed, product;

always @(posedge clk or posedge rst) begin
    if (rst) begin          // 复位时清零 A 和 B
        A_reg <= 32'b0;
        B_reg <= 32'b0;
    end
    else begin
        if (key1)           // 按键1按下时，锁存A
            A_reg <= sw;
        if (key2)           // 按键2按下时，锁存B
            B_reg <= sw;
    end
end


// 实例化乘法器IP核
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

// 输出选择
assign product = sel_ip ? P_signed : P_unsigned;
assign led = product[63:32];  // LED显示高32位

// 实例化数码管显示模块
Display u_Display (
    .clk(clk),
    .data(product[31:0]),  // 数码管显示低32位
    .seg(seg),
    .which(which)
);

endmodule