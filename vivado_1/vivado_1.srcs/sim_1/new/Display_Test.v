`timescale 1ns / 1ps

module Board_tb;

    // Inputs
    reg [31:0] sw;
    reg [7:0] swb;
    reg clk;

    // Outputs
    wire [31:0] led;
    wire [2:0] which;
    wire [7:0] seg;
    wire enable;

    // Instantiate the Unit Under Test (UUT)
    Board uut (
        .sw(sw), 
        .swb(swb), 
        .led(led), 
        .clk(clk), 
        .which(which), 
        .seg(seg), 
        .enable(enable)
    );

    // Clock generation (10 MHz)
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns period (100MHz)
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        sw = 32'h0;
        swb = 8'b0;

        #100;
        sw = 32'hA5A5A5A5; // Set switches
        #100;
        swb = 8'b0000_0001; 
        #100;
        swb = 8'b0;
        #100;
        swb = 8'b0000_0010; // Press 2nd key (toggle=1 again)
        #100;
        sw = 32'h12345678; // Change display data
        #500;
    end

endmodule