`timescale 1ns / 1ps

module CPU_TEST;

    // �����ź�
    reg clk;
    reg mclk;
    reg rst;
    reg sw_ALU;
    reg sw_ZFOF;
    reg sw_M_R;
    reg sw_W_Data;
    
    // ����ź�
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;
    wire [31:0] Inst_code;
    
    // ʵ����CPU
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
    
    // ʱ������
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHzʱ��
    end
    
    // �ֶ�ʱ�����ɣ����ڵ���ִ�У�
    initial begin
        mclk = 0;
        #100; // �ȴ���λ���
        // ִ��10��ָ��
        repeat (10) begin
            #50 mclk = ~mclk;
            #50 mclk = ~mclk;
        end
    end
    
    // ��ʾ�����źų�ʼ�� - �޸������������һ��ʼ����ʾALU���
    initial begin
        sw_ALU = 1;  // ��ʼ��ʾALU���
        sw_ZFOF = 0;
        sw_M_R = 0;
        sw_W_Data = 0;
    end
    
    // ����������
    initial begin
        // ��ʼ��
        rst = 1;
        #100;
        rst = 0;
        
        // ������Ѿ���ʾALU���
        
        // ����2����ʾ��־λ
        #200;
        sw_ALU = 0;
        sw_ZFOF = 1;
        #200;
        
        // ����3����ʾ�洢������
        sw_ZFOF = 0;
        sw_M_R = 1;
        #200;
        
        // ����4����ʾд������
        sw_M_R = 0;
        sw_W_Data = 1;
        #200;
        
        // ��������
    end
    
    // ������
    always @(posedge mclk) begin
        $display("Time = %0t, PC = %h, Inst = %h", $time, uut.PC_init.PC, Inst_code);
        $display("ALU Result = %h, ZF = %b, OF = %b", uut.F, uut.out_ZF_OF[0], uut.out_ZF_OF[1]);
        $display("Write_Reg = %h", uut.Write_Reg);  // ֱ�ӷ��� CPU ģ��� Write_Reg
    end
    
    // ����VCD�����ļ�
    initial begin
        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, CPU_TEST);
    end
    
endmodule