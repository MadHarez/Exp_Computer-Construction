module ALU_TEST;
	// Inputs
	reg [2:0] AB_SW;
	reg [2:0] ALU_OP;
	reg [2:0] F_LED_SW;
	// Outputs
	wire [7:0] LED;
	ALU uut (
		.AB_SW(AB_SW), 
		.ALU_OP(ALU_OP), 
		.F_LED_SW(F_LED_SW), 
		.LED(LED)
	);
	initial begin
		AB_SW = 3'b001;
		ALU_OP = 3'b000;
		F_LED_SW = 3'b000;
		#100;
     	AB_SW = 3'b001;
		ALU_OP = 3'b001;
		F_LED_SW = 3'b000;
		#100;
      	AB_SW = 3'b001;
		ALU_OP = 3'b010;
		F_LED_SW = 3'b000;
	end   
endmodule

`timescale 1ns / 1ps
 
module ALU_TEST();
    reg[31:0] A;
    reg[31:0] B;
    reg[3:0] ALU_OP;
    wire[3:0] flags; //˳��ZF��SF��CF��OF
 
initial
        begin
            A = 32'h8000_0003;
            B = 32'h0000_0001;
    
            #100
            ALU_OP = 4'b0000;   //�ӷ�
           
            #100
            ALU_OP = 4'b0001;   //�߼�����
            
            #100
            ALU_OP = 4'b0010;   //�з������Ƚ�          
 
            #100
            ALU_OP = 4'b0011;   //�޷������Ƚ�            
 
            #100
            ALU_OP = 4'b0100;   //���
            
            #100
            ALU_OP = 4'b0101;   //�߼�����
            
            #100
            ALU_OP = 4'b0110;   //��λ��
            
            #100
            ALU_OP = 4'b0111;   //��λ��
           
            #100
            ALU_OP = 4'b1000;   //����
            
            #100
            ALU_OP = 4'b1001;   //��������
        end    
    ALU alu_sim(A,B,ALU_OP,res,flags);
 
endmodule