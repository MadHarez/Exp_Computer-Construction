`timescale 1ns / 1ps

module CPU_Test;

    // �����ź�
    reg clk;
    reg mclk;
    reg rst;
    reg sw_ALU;
    reg sw_M_R;
    reg sw_PC;
    reg sw_ZFOF;
    
    // ����ź�
    wire [31:0] Inst_code;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;
    
    // ʵ�������ⵥԪ
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
    
    // ʱ������
    initial begin
        sw_ALU =1;
        clk = 0;
        mclk = 0;
        forever begin
            #5 clk = ~clk;  // 100MHz ʱ��
            #1 mclk = ~mclk; // 500MHz �洢��ʱ��
        end
    end
    
    // ��������
    initial begin
        // ��ʼ������
        rst = 1;
        sw_M_R = 0;
        sw_PC = 0;
        sw_ZFOF = 0;
        
        // ��λϵͳ
        #20;
        rst = 0;
        #20;
        
        // ����1: ��ʾALU������
        $display("=== ����1: ��ʾALU������ ===");
        sw_ALU = 1;
        #100;
        
        // ����2: ��ʾ�洢����������
        $display("=== ����2: ��ʾ�洢���������� ===");
        sw_ALU = 0;
        sw_M_R = 1;
        #100;
        
        // ����3: ��ʾ��ǰPCֵ
        $display("=== ����3: ��ʾ��ǰPCֵ ===");
        sw_M_R = 0;
        sw_PC = 1;
        #100;
        
        // ����4: ��ʾZF��OF��־λ
        $display("=== ����4: ��ʾZF��OF��־λ ===");
        sw_PC = 0;
        sw_ZFOF = 1;
        #100;
        
        // ����5: ѭ���л���ʾģʽ
        $display("=== ����5: ѭ���л���ʾģʽ ===");
        repeat (4) begin
            sw_ALU = ~sw_ALU;
            sw_M_R = ~sw_M_R & sw_ALU;
            sw_PC = ~sw_PC & sw_M_R & sw_ALU;
            sw_ZFOF = ~sw_ZFOF & sw_PC & sw_M_R & sw_ALU;
            #100;
        end
        
        // ��������
        $display("=== ������� ===");
        $finish;
    end
    
    // ������
    always @(posedge clk) begin
        $display("ʱ��: %t", $time);
        $display("ָ����: %h", Inst_code);
        $display("�����ѡ���ź�: which=%b, seg=%b, enable=%b", which, seg, enable);
        
        if (sw_ALU)
            $display("��ʾģʽ: ALU������");
        else if (sw_M_R)
            $display("��ʾģʽ: �洢����������");
        else if (sw_PC)
            $display("��ʾģʽ: ��ǰPCֵ");
        else if (sw_ZFOF)
            $display("��ʾģʽ: ZF��OF��־λ");
    end
    
endmodule