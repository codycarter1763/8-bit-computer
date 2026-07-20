`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 04:55:29 PM
// Design Name: 
// Module Name: ram
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


module ram(
    input wire clk,
    input wire ri,
    input wire [3:0] address,
    input wire [7:0] data_in,
    output wire [7:0] data_out
    );
    
    // Opcodes
    localparam
        NOP = 4'h0,
        LDA = 4'h1,
        ADD = 4'h2,
        SUB = 4'h3,
        STA = 4'h4,
        LDI = 4'h5,
        JMP = 4'h6,
        OUT = 4'hE,
        HLT = 4'hF;
    
    reg [7:0] memory [0:15];
    initial begin
        memory[0]  = {LDI, 4'd7};   // LDI 7
        memory[1]  = {ADD, 4'd15};  // ADD 15
        memory[2]  = {OUT, 4'd0};   // OUT
        memory[3]  = {HLT, 4'd0};   // HLT
        memory[4]  = 8'h00;
        memory[5]  = 8'h00;
        memory[6]  = 8'h00;
        memory[7]  = 8'h00;
        memory[8]  = 8'h00;
        memory[9]  = 8'h00;
        memory[10] = 8'h00;
        memory[11] = 8'h00;
        memory[12] = 8'h00;
        memory[13] = 8'h00;

        memory[14] = 8'h0A;   // First operand
        memory[15] = 8'h04;   // Second operand
    end
    always @(posedge clk) begin
        if (ri)
            memory[address] <= data_in; // Write
        end
        
        assign data_out = memory[address]; // Read
endmodule
