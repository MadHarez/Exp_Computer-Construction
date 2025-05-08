//module input_val (
//    input wire clk,          // ʱ���ź�
//    input wire rst_n,        // ��λ�źţ��͵�ƽ��Ч
//    input wire key1,         // ����1���������������A
//    input wire key2,         // ����2���������������B
//    input wire key3,         // ����3����������ALU_OP
//    input wire [31:0] input_data, // 32λ�������ݣ���������A
//    output reg [31:0] A,     // 32λ������A
//    output reg [31:0] B,     // 32λ������B
//    output reg [3:0] ALU_OP  // 4λALU������
//);

//    // ����1����ʱ�����������ݸ�ֵ��A
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            A <= 32'h0; // ��λʱA����
//        end else if (key1) begin
//            A <= input_data; // ���°���1ʱ�����������ݸ�ֵ��A
//        end
//    end

//    // ����2����ʱ�����������ݸ�ֵ��B
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            B <= 32'h0; // ��λʱB����
//        end else if (key2) begin
//            B <= input_data; // ���°���2ʱ�����������ݸ�ֵ��B
//        end
//    end

//    // ����3����ʱ�������صĵ�4λֵ��ֵ��ALU_OP
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            ALU_OP <= 4'b1001; // ��λʱALU_OP����
//        end else if (key3) begin
//            ALU_OP <= input_data[3:0]; // ���°���3ʱ��������ֵ��ֵ��ALU_OP
//        end
//    end

//endmodule

module input_val (
    input wire clk,          // ʱ���ź�
    input wire rst_n,        // ��λ�źţ��͵�ƽ��Ч
    input wire key1,         // ����1���������������A
    input wire key2,         // ����2���������������B
    input wire key3,         // ����3����������ALU_OP
    input wire [31:0] input_data, // 32λ�������ݣ���������A
    output reg [31:0] A,     // 32λ������A����ʼֵΪ0
    output reg [31:0] B,     // 32λ������B����ʼֵΪ0
    output reg [3:0] ALU_OP // 4λALU�����룬��ʼֵΪ9
);

//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            A <= 32'h0;      // ��λʱA����
//            B <= 32'h0;      // ��λʱB����
//            ALU_OP <= 4'b1001; // ��λʱALU_OP����ΪĬ��ֵ
//        end
//    end
    
    // ����1����ʱ�����������ݸ�ֵ��A
    always @(posedge key1) begin
        A <= input_data; // ���°���1ʱ�����������ݸ�ֵ��A
    end

    // ����2����ʱ�����������ݸ�ֵ��B
    always @(posedge key2) begin
        B <= input_data; // ���°���2ʱ�����������ݸ�ֵ��B
    end

    // ����3����ʱ�����������ݵĵ�4λֵ��ֵ��ALU_OP
    always @(posedge key3) begin
        ALU_OP <= input_data[3:0]; // ���°���3ʱ�����������ݵĵ�4λ��ֵ��ALU_OP
    /*    for (integer i = 0; i < 4; i = i + 1) begin
            ALU_OP[i] <= input_data[3 - i];
        end*/
    end

endmodule 