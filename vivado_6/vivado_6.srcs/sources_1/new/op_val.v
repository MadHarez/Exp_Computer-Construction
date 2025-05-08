module op_val(
    input wire [3:0] ALU_OP,
    input wire [31:0] A,
    input wire [31:0] B,
    output reg [31:0] F,
    output reg ZF = 0,
    output reg OF = 0
);
    reg C32 = 0;
    always @(*)
    begin
        case(ALU_OP)
            4'b0000: F <= A & B;
            4'b0001: F <= A | B;
            4'b0010: F <= A ^ B;
            4'b0011: F <=  ~(A | B);
            4'b0100: {C32, F} <= A + B;
            4'b0101: {C32, F} <= A - B;
            4'b0110: begin if (A < B) F <= 32'h0000_0001; else F <= 32'h0000_0000; end
            4'b0111: F <= B << A;
            4'b1000: {C32, F} <= A + 1;
        endcase
        if (F == 32'h0000_0000) ZF <= 1;
        else ZF <= 0;
        OF <= C32 ^ F[31] ^ A[31] ^ B[31];
    end
endmodule