`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 04:39:44 PM
// Design Name: 
// Module Name: register
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


module register(
    input wire clk,
    input wire clr,
    input wire en,
    input wire [7:0] reg_in,
    output reg [7:0] reg_out
    );
    
    always @(posedge clk) begin
        if (clr)
            reg_out <= 8'b0;
        else if (en)
            reg_out <= reg_in;
        end
endmodule
