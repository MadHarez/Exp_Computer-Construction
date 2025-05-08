`timescale 1ns / 1ps

module CPU_Test;
    // 输入信号
    reg clk;
    reg mclk;
    reg rst;
    reg Write_Reg;
    reg sw_F_ZFOF; // 添加切换显示ALU结果或标志位的开关信号
    
    // 输出信号
    wire [31:0] output_signal;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;
    
    // 实例化CPU模块
    CPU uut (
        .clk(clk),
        .rst(rst),
        .Write_Reg(Write_Reg),
        .sw_F_ZFOF(sw_F_ZFOF), // 连接切换显示信号
        .output_signal(output_signal),
        .which(which),
        .seg(seg),
        .enable(enable),
        .mclk(mclk)
    );
    
    // 时钟生成 - 周期40ns (25MHz)
    always #20 clk = ~clk;
    
    initial begin
        // 初始化信号
        clk = 0;
        rst = 1;      // 初始复位状态
        Write_Reg = 1; // 允许寄存器写入
        sw_F_ZFOF = 0; // 初始不显示标志位
        
        // 复位脉冲
        #50;          // 等待50ns
        rst = 0;      // 释放复位
        
        // 切换显示标志位
        #100;
        sw_F_ZFOF = 1;
        
        // 运行足够长时间观察结果
        #500;        // 运行1微秒
        sw_F_ZFOF = 0;
        #500;        // 运行1微秒
        // 结束仿真
        $finish;
    end
    
    // 监视重要信号
    initial begin
        $monitor("Time=%0t output_signal=%h sw_F_ZFOF=%b", 
                 $time, output_signal, sw_F_ZFOF);
    end
    
    // 可选：生成VCD波形文件
    initial begin
        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, CPU_Test);
    end
endmodule