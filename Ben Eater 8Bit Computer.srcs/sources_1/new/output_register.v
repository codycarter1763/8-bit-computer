`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 08:09:57 PM
// Design Name: 
// Module Name: output_register
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


module output_register(
    input  wire       clk,
    input  wire [3:0] digit0,   // rightmost
    input  wire [3:0] digit1,
    input  wire [3:0] digit2,
    input  wire [3:0] digit3,   // leftmost
    output reg  [6:0] seg,      // active-low segments CA..CG (Basys3 wiring)
    output reg  [3:0] an        // active-low digit enables
);
 
    reg [1:0]  sel;
    reg [19:0] refresh_count; // 20-bit: 100MHz/2^20 ~ 95Hz full-cycle,
                              // ~190Hz per digit (2.6ms/digit) -- matches
                              // the documented flicker-free range (1kHz-60Hz
                              // refresh, per fpga4student's Basys3 7-seg tutorial)
 
    always @(posedge clk) begin
        refresh_count <= refresh_count + 1'b1;
    end
    always @(*) sel = refresh_count[19:18];
 
    reg [3:0] nibble;
    always @(*) begin
        case (sel)
            2'd0: begin nibble = digit0; an = 4'b1110; end
            2'd1: begin nibble = digit1; an = 4'b1101; end
            2'd2: begin nibble = digit2; an = 4'b1011; end
            2'd3: begin nibble = digit3; an = 4'b0111; end
        endcase
    end
 
    // Active-low segment patterns
    always @(*) begin
        case (nibble)
            4'h0: seg = 7'b0000001;
            4'h1: seg = 7'b1001111;
            4'h2: seg = 7'b0010010;
            4'h3: seg = 7'b0000110;
            4'h4: seg = 7'b1001100;
            4'h5: seg = 7'b0100100;
            4'h6: seg = 7'b0100000;
            4'h7: seg = 7'b0001111;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0000100;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000000;
            4'hC: seg = 7'b0110000;
            4'hD: seg = 7'b0000001;
            4'hE: seg = 7'b0110000;
            4'hF: seg = 7'b0011000;
            default: seg = 7'b1111111;
        endcase
    end
 
endmodule
