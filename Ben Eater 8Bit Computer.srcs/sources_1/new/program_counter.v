`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 07:53:32 PM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input wire clk,
    input wire clr,
    input wire count_en,
    input wire jump,
    input wire [7:0] bus_input,
    output reg [3:0] count
    );
    
    always @(posedge clk) begin
        if (clr)
            count <= 4'b0;
        else if (jump)
            count <= bus_input [3:0];
        else if (count_en)
            count <= count + 1'b1;
    end
endmodule
