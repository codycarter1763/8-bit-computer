`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2026 02:30:57 PM
// Design Name: 
// Module Name: cpu_flags_register
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


module cpu_flags_register(
    input wire clk,
    input wire clr,
    input wire fi,
    input wire [7:0] reg_in,
    input wire carry_out,
    output reg zero_flag,
    output reg carry_out_flag
    );
    
    always @(posedge clk) begin
        if (clr) begin
            zero_flag <= 1'b0;
            carry_out_flag <= 1'b0;
        end
        else if (fi) begin
            zero_flag <= (reg_in == 8'h00);
            carry_out_flag <= carry_out;
        end
    end
endmodule
