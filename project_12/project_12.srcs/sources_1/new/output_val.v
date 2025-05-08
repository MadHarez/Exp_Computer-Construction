`timescale 1ns / 1ps

module output_val(
    input clk,                  // 系统时钟
    input [31:0]display_data,            // 显示写入存储器数据
    output reg [2:0] which = 0, // 片选编码（驱动哪一位数码管），低电平有效
    output reg [7:0] seg,       // 段选信号（点亮哪些笔划），低电平有效
    output reg enable = 1       // 数码管使能信号（新增）
);

    reg [14:0] count = 0;        // 分频计数器
    reg [3:0] digit;            // 当前显示的十六进制数码

    // 分频扫描逻辑
    always @(posedge clk) begin
        count <= count + 1'b1;
    end

    // 片选逻辑（循环驱动每一位数码管）
    always @(negedge clk) begin
        if (&count) which <= which + 1'b1;
    end


    // 片选当前数码管对应的数据位
    always @(*) begin
        case (which)
            0: digit = display_data[31:28]; // 最高位
            1: digit = display_data[27:24];
            2: digit = display_data[23:20];
            3: digit = display_data[19:16];
            4: digit = display_data[15:12];
            5: digit = display_data[11:8];
            6: digit = display_data[7:4];
            7: digit = display_data[3:0];   // 最低位
        endcase
    end

    // 十六进制数码转换为段选信号（共阳极数码管，0 点亮）
    always @(*) begin
        case (digit)
            4'h0: seg = 8'b0000_0011; // 显示 0
            4'h1: seg = 8'b1001_1111; // 显示 1
            4'h2: seg = 8'b0010_0101; // 显示 2
            4'h3: seg = 8'b0000_1101; // 显示 3
            4'h4: seg = 8'b1001_1001; // 显示 4
            4'h5: seg = 8'b0100_1001; // 显示 5
            4'h6: seg = 8'b0100_0001; // 显示 6
            4'h7: seg = 8'b0001_1111; // 显示 7
            4'h8: seg = 8'b0000_0001; // 显示 8
            4'h9: seg = 8'b0000_1001; // 显示 9
            4'hA: seg = 8'b0001_0001; // 显示 A
            4'hB: seg = 8'b1100_0001; // 显示 B
            4'hC: seg = 8'b0110_0011; // 显示 C
            4'hD: seg = 8'b1000_0101; // 显示 D
            4'hE: seg = 8'b0110_0001; // 显示 E
            4'hF: seg = 8'b0111_0001; // 显示 F
        endcase
    end

endmodule