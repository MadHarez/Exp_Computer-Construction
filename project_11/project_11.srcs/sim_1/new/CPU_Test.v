`timescale 1ns / 1ps

module CPU_Test;
    // �����ź�
    reg clk;
    reg mclk;
    reg rst;
    reg Write_Reg;
    reg sw_F_ZFOF; // ����л���ʾALU������־λ�Ŀ����ź�
    
    // ����ź�
    wire [31:0] output_signal;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;
    
    // ʵ����CPUģ��
    CPU uut (
        .clk(clk),
        .rst(rst),
        .Write_Reg(Write_Reg),
        .sw_F_ZFOF(sw_F_ZFOF), // �����л���ʾ�ź�
        .output_signal(output_signal),
        .which(which),
        .seg(seg),
        .enable(enable),
        .mclk(mclk)
    );
    
    // ʱ������ - ����40ns (25MHz)
    always #20 clk = ~clk;
    
    initial begin
        // ��ʼ���ź�
        clk = 0;
        rst = 1;      // ��ʼ��λ״̬
        Write_Reg = 1; // ����Ĵ���д��
        sw_F_ZFOF = 0; // ��ʼ����ʾ��־λ
        
        // ��λ����
        #50;          // �ȴ�50ns
        rst = 0;      // �ͷŸ�λ
        
        // �л���ʾ��־λ
        #100;
        sw_F_ZFOF = 1;
        
        // �����㹻��ʱ��۲���
        #500;        // ����1΢��
        sw_F_ZFOF = 0;
        #500;        // ����1΢��
        // ��������
        $finish;
    end
    
    // ������Ҫ�ź�
    initial begin
        $monitor("Time=%0t output_signal=%h sw_F_ZFOF=%b", 
                 $time, output_signal, sw_F_ZFOF);
    end
    
    // ��ѡ������VCD�����ļ�
    initial begin
        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, CPU_Test);
    end
endmodule