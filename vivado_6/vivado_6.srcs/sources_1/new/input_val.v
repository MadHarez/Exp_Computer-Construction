//module input_val (
//    input wire clk,          // 时钟信号
//    input wire rst_n,        // 复位信号，低电平有效
//    input wire key1,         // 按键1，用于输入操作数A
//    input wire key2,         // 按键2，用于输入操作数B
//    input wire key3,         // 按键3，用于设置ALU_OP
//    input wire [31:0] input_data, // 32位输入数据，用于设置A
//    output reg [31:0] A,     // 32位操作数A
//    output reg [31:0] B,     // 32位操作数B
//    output reg [3:0] ALU_OP  // 4位ALU操作码
//);

//    // 按键1按下时，将输入数据赋值给A
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            A <= 32'h0; // 复位时A清零
//        end else if (key1) begin
//            A <= input_data; // 按下按键1时，将输入数据赋值给A
//        end
//    end

//    // 按键2按下时，将输入数据赋值给B
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            B <= 32'h0; // 复位时B清零
//        end else if (key2) begin
//            B <= input_data; // 按下按键2时，将输入数据赋值给B
//        end
//    end

//    // 按键3按下时，将开关的低4位值赋值给ALU_OP
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            ALU_OP <= 4'b1001; // 复位时ALU_OP清零
//        end else if (key3) begin
//            ALU_OP <= input_data[3:0]; // 按下按键3时，将开关值赋值给ALU_OP
//        end
//    end

//endmodule

module input_val (
    input wire clk,          // 时钟信号
    input wire rst_n,        // 复位信号，低电平有效
    input wire key1,         // 按键1，用于输入操作数A
    input wire key2,         // 按键2，用于输入操作数B
    input wire key3,         // 按键3，用于设置ALU_OP
    input wire [31:0] input_data, // 32位输入数据，用于设置A
    output reg [31:0] A,     // 32位操作数A，初始值为0
    output reg [31:0] B,     // 32位操作数B，初始值为0
    output reg [3:0] ALU_OP // 4位ALU操作码，初始值为9
);

//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            A <= 32'h0;      // 复位时A清零
//            B <= 32'h0;      // 复位时B清零
//            ALU_OP <= 4'b1001; // 复位时ALU_OP设置为默认值
//        end
//    end
    
    // 按键1按下时，将输入数据赋值给A
    always @(posedge key1) begin
        A <= input_data; // 按下按键1时，将输入数据赋值给A
    end

    // 按键2按下时，将输入数据赋值给B
    always @(posedge key2) begin
        B <= input_data; // 按下按键2时，将输入数据赋值给B
    end

    // 按键3按下时，将输入数据的低4位值赋值给ALU_OP
    always @(posedge key3) begin
        ALU_OP <= input_data[3:0]; // 按下按键3时，将输入数据的低4位赋值给ALU_OP
    /*    for (integer i = 0; i < 4; i = i + 1) begin
            ALU_OP[i] <= input_data[3 - i];
        end*/
    end

endmodule 