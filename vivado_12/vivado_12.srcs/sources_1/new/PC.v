`timescale 1ns / 1ps

module PC(
    input clk,
    input rst,
    
    output reg [31:0] Inst_code,
    output reg [31:0] PC,
    output [31:0] PC_new
);
    
    // PC初始化
    initial begin
        PC = 32'h0000_0000;
        Inst_code = 32'h0000_0000;
    end

    // PC+4计算
    assign PC_new = PC + 4;

    // 指令ROM实例化
    Inst_ROM Inst_ROM_init(
      .clka(clk), // input clka
      .addra(PC[7:2]), // input [5 : 0] addra
      .douta(Inst_code) // output [31 : 0] douta
    );
    
    
    always@(negedge clk or posedge rst)
	begin
		if(rst)
			begin PC <= 32'h0000_0000; end
		else
			begin PC <= PC_new; end
	end
endmodule