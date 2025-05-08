`timescale 1ns / 1ps

module CPU_Test;

    // 输入信号
    reg clk;
    reg mclk;
    reg rst;
    reg sw_ALU;
    reg sw_M_R;
    reg sw_PC;
    reg sw_ZFOF;
    
    // 输出信号
    wire [31:0] Inst_code;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;
    
    // 实例化被测单元
    CPU uut (
        .clk(clk),
        .mclk(mclk),
        .rst(rst),
        .sw_ALU(sw_ALU),
        .sw_M_R(sw_M_R),
        .sw_PC(sw_PC),
        .sw_ZFOF(sw_ZFOF),
        .Inst_code(Inst_code),
        .which(which),
        .seg(seg),
        .enable(enable)
    );
    
    // 时钟生成
    initial begin
        sw_ALU =1;
        clk = 0;
        mclk = 0;
        forever begin
            #5 clk = ~clk;  // 100MHz 时钟
            #1 mclk = ~mclk; // 500MHz 存储器时钟
        end
    end
    
    // 测试流程
    initial begin
        // 初始化输入
        rst = 1;
        sw_M_R = 0;
        sw_PC = 0;
        sw_ZFOF = 0;
        
        // 复位系统
        #20;
        rst = 0;
        #20;
        
        // 测试1: 显示ALU运算结果
        $display("=== 测试1: 显示ALU运算结果 ===");
        sw_ALU = 1;
        #100;
        
        // 测试2: 显示存储器读出数据
        $display("=== 测试2: 显示存储器读出数据 ===");
        sw_ALU = 0;
        sw_M_R = 1;
        #100;
        
        // 测试3: 显示当前PC值
        $display("=== 测试3: 显示当前PC值 ===");
        sw_M_R = 0;
        sw_PC = 1;
        #100;
        
        // 测试4: 显示ZF和OF标志位
        $display("=== 测试4: 显示ZF和OF标志位 ===");
        sw_PC = 0;
        sw_ZFOF = 1;
        #100;
        
        // 测试5: 循环切换显示模式
        $display("=== 测试5: 循环切换显示模式 ===");
        repeat (4) begin
            sw_ALU = ~sw_ALU;
            sw_M_R = ~sw_M_R & sw_ALU;
            sw_PC = ~sw_PC & sw_M_R & sw_ALU;
            sw_ZFOF = ~sw_ZFOF & sw_PC & sw_M_R & sw_ALU;
            #100;
        end
        
        // 结束测试
        $display("=== 测试完成 ===");
        $finish;
    end
    
    // 监控输出
    always @(posedge clk) begin
        $display("时间: %t", $time);
        $display("指令码: %h", Inst_code);
        $display("数码管选择信号: which=%b, seg=%b, enable=%b", which, seg, enable);
        
        if (sw_ALU)
            $display("显示模式: ALU运算结果");
        else if (sw_M_R)
            $display("显示模式: 存储器读出数据");
        else if (sw_PC)
            $display("显示模式: 当前PC值");
        else if (sw_ZFOF)
            $display("显示模式: ZF和OF标志位");
    end
    
endmodule