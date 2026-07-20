`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 05:01:39 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input  wire [7:0] a_register,
    input  wire [7:0] b_register,
    output reg  [7:0] answer,
    input  wire clr,
    input  wire sum_output,
    input  wire subtract,
    output reg  carry_out
    );

    always @(*) begin
        if (clr) begin
            answer    = 8'b0;
            carry_out = 1'b0;
        end

        else if (subtract) begin
            {carry_out, answer} = a_register - b_register;
        end

        else begin
            {carry_out, answer} = a_register + b_register;
        end
    end

endmodule
