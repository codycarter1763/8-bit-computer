`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 11:16:54 PM
// Design Name: 
// Module Name: cpu
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


module cpu(
    input wire clk,
    input wire clr,
    output wire [6:0] seg,
    output wire [3:0] an
    );

    //========================================================
    // Common Bus
    //========================================================
    reg [7:0] bus;

    //========================================================
    // Control Signals
    //========================================================
    wire HLT;
    wire MI;
    wire RI;
    wire RO;
    wire IO;
    wire II;
    wire AI;
    wire AO;
    wire SUM;
    wire SU;
    wire BI;
    wire OI;
    wire CE;
    wire CO;
    wire J;

    //========================================================
    // Internal Signals
    //========================================================

    wire [3:0] pc_out;
    wire [3:0] mar_out;

    wire [7:0] ram_out;

    wire [7:0] ir_out;
    wire [3:0] opcode;

    assign opcode = ir_out[7:4];

    wire [7:0] a_out;
    wire [7:0] b_out;

    wire [7:0] alu_out;
    wire alu_carry;

    wire [7:0] out_reg;

    //========================================================
    // Program Counter
    //========================================================

    program_counter PC(
        .clk(clk),
        .clr(clr),
        .count_en(CE),
        .jump(J),
        .bus_input(bus),
        .count(pc_out)
    );

    //========================================================
    // Memory Address Register
    //========================================================

    memory_address_register MAR(
        .clk(clk),
        .clr(clr),
        .enable(MI),
        .bus_input(bus),
        .address(mar_out)
    );

    //========================================================
    // RAM
    //========================================================

    ram RAM(
        .clk(clk),
        .ri(RI),
        .address(mar_out),
        .data_in(bus),
        .data_out(ram_out)
    );

    //========================================================
    // Instruction Register
    //========================================================

    instruction_register IR(
        .clk(clk),
        .clr(clr),
        .en(II),
        .reg_in(bus),
        .instruction(ir_out)
    );

    //========================================================
    // A Register
    //========================================================

    register A(
        .clk(clk),
        .clr(clr),
        .en(AI),
        .reg_in(bus),
        .reg_out(a_out)
    );

    //========================================================
    // B Register
    //========================================================

    register B(
        .clk(clk),
        .clr(clr),
        .en(BI),
        .reg_in(bus),
        .reg_out(b_out)
    );

    //========================================================
    // Output Register
    //========================================================

    register OUTPUT(
        .clk(clk),
        .clr(clr),
        .en(OI),
        .reg_in(bus),
        .reg_out(out_reg)
    );

    //========================================================
    // ALU
    //========================================================

    ALU alu(
        .a_register(a_out),
        .b_register(b_out),
        .answer(alu_out),
        .clr(clr),
        .sum_output(SUM),
        .subtract(SU),
        .carry_out(alu_carry)
    );

    //========================================================
    // Control Unit
    //========================================================

    control_unit CU(
        .clk(clk),
        .clr(clr),
        .opcode(opcode),

        .HLT(HLT),
        .MI(MI),
        .RI(RI),
        .RO(RO),
        .IO(IO),
        .II(II),
        .AI(AI),
        .AO(AO),
        .SUM(SUM),
        .SU(SU),
        .BI(BI),
        .OI(OI),
        .CE(CE),
        .CO(CO),
        .J(J)
    );

    //========================================================
    // BUS Multiplexer
    //========================================================

    always @(*) begin

        bus = 8'h00;

        // Program Counter
        if (CO)
            bus = {4'b0000, pc_out};

        // RAM
        else if (RO)
            bus = ram_out;

        // Instruction Register Operand
        else if (IO)
            bus = {4'b0000, ir_out[3:0]};

        // A Register
        else if (AO)
            bus = a_out;

        // ALU
        else if (SUM)
            bus = alu_out;

    end

    //========================================================
    // Seven Segment Display Driver
    //========================================================

    output_register DISPLAY(
        .clk(clk),
        .digit0(out_reg[3:0]),
        .digit1(out_reg[7:4]),
        .digit2(4'h0),
        .digit3(4'h0),
        .seg(seg),
        .an(an)
    );

endmodule
