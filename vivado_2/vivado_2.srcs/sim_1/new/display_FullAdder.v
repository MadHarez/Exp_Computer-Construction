`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/01 17:17:14
// Design Name: 
// Module Name: display_FullAdder
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


module display_FullAdder();
    reg A, B, Ci;     
    wire F, C;    
FullAdder FullAdder_utt(
    .A(A),
    .B(B),
    .Ci(Ci),
    .F(F),
    .C(C)
);

initial begin
    A = 0; B = 0; Ci = 0; #100; 
    A = 0; B = 0; Ci = 1; #100; 
    A = 0; B = 1; Ci = 0; #100; 
    A = 0; B = 1; Ci = 1; #100; 
    A = 1; B = 0; Ci = 0; #100;  
    A = 1; B = 0; Ci = 1; #100;  
    A = 1; B = 1; Ci = 0; #100; 
    A = 1; B = 1; Ci = 1; #100; 
    $stop; 
end

endmodule
