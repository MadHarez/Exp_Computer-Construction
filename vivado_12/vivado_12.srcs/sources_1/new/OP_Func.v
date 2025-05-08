`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/29 19:27:19
// Design Name: 
// Module Name: OP_Func
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


module OP_Func(
    input[5:0]op_code,
    input[5:0]funct,
    input clk,
    output reg[3:0]ALU_OP,
    output reg Write_Reg,
    output reg rd_rt_s,
    output reg imm_s,
    output reg rt_imm_s,
    output reg Mem_Write,
    output reg alu_mem_s
    );
    always@(negedge clk)begin
       $display("ALU_OP OP_Func=%b",ALU_OP);
    end
    always@(*)
     begin
        Write_Reg = 1;
        ALU_OP=0;
        rd_rt_s =0;
        rt_imm_s=0;
        Mem_Write =0;
        imm_s=0;
        alu_mem_s=0;
            if(op_code==0)
                begin
                    case(funct)
                    6'b100000:begin ALU_OP=4'b0100;end
                    6'b100010:begin ALU_OP=4'b0101;end
                    6'b100100:begin ALU_OP=4'b0000;end
                    6'b100101:begin ALU_OP=4'b0001;end
                    6'b100110:begin ALU_OP=4'b0010;end
                    6'b100111:begin ALU_OP=4'b0011;end
                    6'b101011:begin ALU_OP=4'b0110;end
                    6'b000100:begin ALU_OP=4'b0111;end
                    endcase
                end
            else
                 begin
                    case(op_code)
                    6'b001000:begin 
                        rd_rt_s =1;
                        imm_s=1;
                        rt_imm_s=1;
                        alu_mem_s=0;
                        ALU_OP=4'b0100;
                        Write_Reg=1;
                        Mem_Write=0;
                        end
                    6'b001100:begin 
                        rd_rt_s =1;
                        imm_s=0;
                        rt_imm_s=1;
                        alu_mem_s=0;
                        ALU_OP=4'b0000;
                        Write_Reg=1;
                        Mem_Write=0;
                    end
                    6'b001110:begin 
                        rd_rt_s =1;
                        imm_s=0;
                        rt_imm_s=1;
                        alu_mem_s=0;
                        ALU_OP=4'b0010;
                        Write_Reg=1;
                        Mem_Write=0;
                        end
                    6'b001011:begin 
                        rd_rt_s =1;
                        imm_s=0;
                        rt_imm_s=1;
                        alu_mem_s=0;
                        ALU_OP=4'b0110; 
                        Write_Reg=1;
                        Mem_Write=0;
                        end
                    6'b100011:begin 
                        rd_rt_s =1;
                        imm_s=1;
                        rt_imm_s=1;
                        alu_mem_s=1;
                        ALU_OP=4'b0100;
                        Write_Reg=1;
                        Mem_Write=0;
                        end
                    6'b101011:begin 
                        rd_rt_s =1;
                        imm_s=0;
                        rt_imm_s=1;
                        alu_mem_s=0;
                        ALU_OP=4'b0100;
                        Write_Reg=0;
                        Mem_Write=1;
                        end
                    endcase
                    end
                end
endmodule
