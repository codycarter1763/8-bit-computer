`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 11:56:15 PM
// Design Name: 
// Module Name: cpu_tb
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


`timescale 1ns / 1ps

module cpu_tb;

    // Inputs
    reg clk;
    reg clr;

    // Outputs
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate CPU
    cpu DUT (
        .clk(clk),
        .clr(clr),
        .seg(seg),
        .an(an)
    );

    //----------------------------------------
    // Clock Generator
    //----------------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;      // 500ns period
    end

    //----------------------------------------
    // Reset
    //----------------------------------------

    initial begin

        clr = 1;

        #20;

        clr = 0;

        #1000;

        $finish;

    end

endmodule
