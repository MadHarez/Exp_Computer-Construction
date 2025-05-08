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
    wire[3:0] flags; //顺序：ZF、SF、CF、OF
 
initial
        begin
            A = 32'h8000_0003;
            B = 32'h0000_0001;
    
            #100
            ALU_OP = 4'b0000;   //加法
           
            #100
            ALU_OP = 4'b0001;   //逻辑左移
            
            #100
            ALU_OP = 4'b0010;   //有符号数比较          
 
            #100
            ALU_OP = 4'b0011;   //无符号数比较            
 
            #100
            ALU_OP = 4'b0100;   //异或
            
            #100
            ALU_OP = 4'b0101;   //逻辑右移
            
            #100
            ALU_OP = 4'b0110;   //按位或
            
            #100
            ALU_OP = 4'b0111;   //按位与
           
            #100
            ALU_OP = 4'b1000;   //减法
            
            #100
            ALU_OP = 4'b1001;   //算术右移
        end    
    ALU alu_sim(A,B,ALU_OP,res,flags);
 
endmodule