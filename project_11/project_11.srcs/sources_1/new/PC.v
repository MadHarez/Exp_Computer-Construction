`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/29 09:51:02
// Design Name: 
// Module Name: PC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC(clk,rst,Inst_code);
    input clk,rst;
    
    
    wire [31:0]PC_new;
    reg [31:0]PC;
    
    initial
        PC = 32'h0000_0000;
        
    output [31:0]Inst_code;
    
    assign PC_new = PC + 4;
    
Inst_ROM Inst_ROM_init (
.clka(clk), // input clka
.addra(PC[7:2]), // input [5 : 0] addra
.douta(Inst_code) // output [31 : 0] douta
);


always@(negedge clk)begin
    $display("%d --- %h --- 7_2%d",PC,Inst_code,PC[7:2]);
end

always@(negedge clk or posedge rst)
	begin
		if(rst)
			begin PC <= 32'h0000_0000; end
		else
			begin PC <=PC_new; end
	end
endmodule