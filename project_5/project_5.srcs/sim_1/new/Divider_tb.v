`timescale 1ns / 1ps

module Divider_tb;

    // 输入信号
    reg clk = 0;
    reg rst = 1;
    reg [31:0] input_data;
    reg input_A;
    reg input_B;
    reg sel_meth = 0;  // 0=阵列除法器，1=IP核
    reg sel_sign = 0;   // 0=无符号，1=有符号

    // 输出信号
    wire [7:0] seg;
    wire enable;
    wire [31:0] leds;
    
    // 时钟生成（100MHz）
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns 周期的时钟
    end
    
    // 实例化被测设计
    Divider uut (
        .clk(clk),
        .rst(rst),
        .input_data(input_data),
        .input_A(input_A),
        .input_B(input_B),
        .sel_meth(sel_meth),
        .sel_sign(sel_sign),
        .seg(seg),
        .enable(enable),
        .leds(leds)
    );
    
    // 测试任务：设置输入值
    task set_input;
        input [31:0] a_val;
        input [31:0] b_val;
        begin
            // 设置A值
            input_data = a_val;
            input_A = 1;
            #10;
            input_A = 0;
            #10;
            
            // 设置B值
            input_data = b_val;
            input_B = 1;
            #10;
            input_B = 0;
            #10;
        end
    endtask
    
    // 主测试流程
    initial begin
        // 初始化
        #20;
        rst = 0;
        #20;
        
//        $display("=== 开始测试阵列除法器（有符号）===");
        sel_meth = 1;
        sel_sign = 1;
        
        // 测试用例1：12 / 3 = 4...0
        // 测试用例1：24 / -31
//        set_input(32'b00000011000,32'b111111);
        // 测试用例2：-24 / -31
//        set_input(32'b00000011000,32'b011111);
//        set_input(32'b110100000,32'b1011);
//        set_input(32'd12,32'd3);
//        #100;
        set_input(32'b1011,32'b0100);
//        #100;
//        // 测试用例2：15 / 4 = 3...3
//        set_input(32'd15, 32'd4);
        
//        // 测试用例3：8 / 5 = 1...3
//        set_input(32'd8, 32'd5);
        
        $display("\n=== 开始测试ip核除法器（有符号）===");
//        sel_meth = 1;
//        sel_sign = 1;
//        set_input(32'b00000011000,32'b011111);
//        // 测试用例4：-12 / 3 = -4...0
//        set_input(-32'd12, 32'd3);
        
//        // 测试用例5：15 / -4 = -3...3
//        set_input(32'd15, -32'd4);
        
//        $display("\n=== 开始测试IP核除法器（无符号）===");
//        sel_meth = 1;
//        sel_sign = 0;
        
//        // 测试用例6：123456 / 256 = 482...64
//        set_input(32'd123456, 32'd256);
        
//        // 测试用例7：65535 / 256 = 255...255
//        set_input(32'd65535, 32'd256);
        
//        $display("\n=== 开始测试IP核除法器（有符号）===");
//        sel_sign = 1;
        
//        // 测试用例8：-123456 / 256 = -482...-64
//        set_input(-32'd123456, 32'd256);
        
//        // 测试用例9：32767 / -128 = -255...127
//        set_input(32'd32767, -32'd128);
        
//        // 测试用例10：除零检测
//        $display("\n=== 测试除零检测 ===");
//        set_input(32'd100, 32'd0);
//        #100;
//        if (uut.ip_inst.ip_error !== 1'b1) begin
//            $display("[ERROR] Divide by zero detection failed");
//        end else begin
//            $display("[PASS] Divide by zero detected correctly");
//        end
        
//        // 测试用例11：显示切换测试
//        $display("\n=== 测试显示切换 ===");
//        sel_meth = 0;
//        set_input(32'd123, 32'd45);
//        #100;
//        sel_meth = 1;
//        #100;
        
//        $display("\n=== 所有测试完成 ===");
//        $finish;
    end
    
//    // 波形记录
//    initial begin
//        $dumpfile("divider_wave.vcd");
//        $dumpvars(0, Divider_tb);
//    end
endmodule