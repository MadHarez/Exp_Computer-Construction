`timescale 1ns / 1ps

module CPU_TEST;

    // 输入信号
    reg clk;
    reg mclk;
    reg rst;
    reg sw_ALU;
    reg sw_ZFOF;
    reg sw_M_R;
    reg sw_W_Data;
    
    // 输出信号
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;
    wire [31:0] Inst_code;
    
    // 实例化CPU
    CPU uut (
        .clk(clk),
        .mclk(mclk),
        .rst(rst),
        .sw_ALU(sw_ALU),
        .sw_ZFOF(sw_ZFOF),
        .sw_M_R(sw_M_R),
        .sw_W_Data(sw_W_Data),
        .which(which),
        .seg(seg),
        .enable(enable),
        .Inst_code(Inst_code)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz时钟
    end
    
    // 手动时钟生成（用于单步执行）
    initial begin
        mclk = 0;
        #100; // 等待复位完成
        // 执行10条指令
        repeat (10) begin
            #50 mclk = ~mclk;
            #50 mclk = ~mclk;
        end
    end
    
    // 显示控制信号初始化 - 修改这里让数码管一开始就显示ALU结果
    initial begin
        sw_ALU = 1;  // 初始显示ALU结果
        sw_ZFOF = 0;
        sw_M_R = 0;
        sw_W_Data = 0;
    end
    
    // 主测试流程
    initial begin
        // 初始化
        rst = 1;
        #100;
        rst = 0;
        
        // 数码管已经显示ALU结果
        
        // 测试2：显示标志位
        #200;
        sw_ALU = 0;
        sw_ZFOF = 1;
        #200;
        
        // 测试3：显示存储器数据
        sw_ZFOF = 0;
        sw_M_R = 1;
        #200;
        
        // 测试4：显示写入数据
        sw_M_R = 0;
        sw_W_Data = 1;
        #200;
        
        // 结束测试
    end
    
    // 监控输出
    always @(posedge mclk) begin
        $display("Time = %0t, PC = %h, Inst = %h", $time, uut.PC_init.PC, Inst_code);
        $display("ALU Result = %h, ZF = %b, OF = %b", uut.F, uut.out_ZF_OF[0], uut.out_ZF_OF[1]);
        $display("Write_Reg = %h", uut.Write_Reg);  // 直接访问 CPU 模块的 Write_Reg
    end
    
    // 生成VCD波形文件
    initial begin
        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, CPU_TEST);
    end
    
endmodule