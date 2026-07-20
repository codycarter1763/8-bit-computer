`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 04:45:45 PM
// Design Name: 
// Module Name: instruction_register
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


module instruction_register(
    input wire clk,
    input wire clr,
    input wire en,
    input wire [7:0] reg_in,
    output reg [7:0] instruction
);

always @(posedge clk) begin
    if (clr)
        instruction <= 8'h00;
    else if (en)
        instruction <= reg_in;
end

endmodule


