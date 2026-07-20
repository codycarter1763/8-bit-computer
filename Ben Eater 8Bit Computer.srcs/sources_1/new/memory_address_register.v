`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 08:01:11 PM
// Design Name: 
// Module Name: memory_address_register
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


module memory_address_register(
    input wire clk,
    input wire clr,
    input wire enable,
    input wire [7:0] bus_input,
    output reg [3:0] address
    );
    
    always @(posedge clk) begin
        if (clr)
            address <= 4'b0;
        else if (enable)
            address <= bus_input[3:0];
    end
endmodule
