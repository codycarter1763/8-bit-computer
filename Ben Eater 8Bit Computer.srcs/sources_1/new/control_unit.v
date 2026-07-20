`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 09:33:33 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input wire clk,
    input wire clr,
    input wire [3:0] opcode,
    output wire
            HLT,
            MI,
            RI,
            RO,
            IO,
            II,
            AI,
            AO,
            SUM,
            SU,
            BI,
            OI,
            CE,
            CO,
            J
    );
    
    localparam 
            HLT_CODE = 16'h8000,
            MI_CODE = 16'h4000,
            RI_CODE = 16'h2000,
            RO_CODE = 16'h1000,
            IO_CODE = 16'h0800,
            II_CODE = 16'h0400,
            AI_CODE = 16'h0200,
            AO_CODE = 16'h0100,
            SUM_CODE = 16'h0080,
            SU_CODE = 16'h0040,
            BI_CODE = 16'h0020,
            OI_CODE = 16'h0010,
            CE_CODE = 16'h0008,
            CO_CODE = 16'h0004,
            J_CODE = 16'h0002;
            
     localparam 
            NOP = 4'h0,
            LDA = 4'h1,
            ADD = 4'h2,
            SUB = 4'h3,
            STA = 4'h4,
            LDI = 4'h5,
            JMP = 4'h6,
            OUT = 4'he,
            HLT_INST = 4'hf;
            
     reg [15:0] microcode [0:15][0:7];
     
     integer i, j;
     
     initial begin
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 8; j = j + 1)
                microcode[i][j] = 16'h0000;
                
        // NOP
        microcode[NOP][0] = CO_CODE | MI_CODE;
        microcode[NOP][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[NOP][2] = 16'h0000;
        microcode[NOP][3] = 16'h0000;
        microcode[NOP][4] = 16'h0000;
        microcode[NOP][5] = 16'h0000;
        microcode[NOP][6] = 16'h0000;
        microcode[NOP][7] = 16'h0000;
        
        // LDA
        microcode[LDA][0] = CO_CODE | MI_CODE;
        microcode[LDA][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[LDA][2] = IO_CODE | MI_CODE;
        microcode[LDA][3] = RO_CODE | AI_CODE;
        microcode[LDA][4] = 16'h0000;
        microcode[LDA][5] = 16'h0000;
        microcode[LDA][6] = 16'h0000;
        microcode[LDA][7] = 16'h0000;
        
        // ADD
        microcode[ADD][0] = CO_CODE | MI_CODE;
        microcode[ADD][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[ADD][2] = IO_CODE | MI_CODE;
        microcode[ADD][3] = RO_CODE | BI_CODE;
        microcode[ADD][4] = SUM_CODE | AI_CODE;
        microcode[ADD][5] = 16'h0000;
        microcode[ADD][6] = 16'h0000;
        microcode[ADD][7] = 16'h0000;
        
        // SUB
        microcode[SUB][0] = CO_CODE | MI_CODE;
        microcode[SUB][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[SUB][2] = IO_CODE | MI_CODE;
        microcode[SUB][3] = RO_CODE | BI_CODE;
        microcode[SUB][4] = SUM_CODE | AI_CODE | SU_CODE;
        microcode[SUB][5] = 16'h0000;
        microcode[SUB][6] = 16'h0000;
        microcode[SUB][7] = 16'h0000;
        
        // STA
        microcode[STA][0] = CO_CODE | MI_CODE;
        microcode[STA][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[STA][2] = IO_CODE | MI_CODE;
        microcode[STA][3] = AO_CODE | RI_CODE;
        microcode[STA][4] = 16'h0000;
        microcode[STA][5] = 16'h0000;
        microcode[STA][6] = 16'h0000;
        microcode[STA][7] = 16'h0000;
        
        // LDI
        microcode[LDI][0] = CO_CODE | MI_CODE;
        microcode[LDI][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[LDI][2] = IO_CODE | AI_CODE;
        microcode[LDI][3] = 16'h0000;
        microcode[LDI][4] = 16'h0000;
        microcode[LDI][5] = 16'h0000;
        microcode[LDI][6] = 16'h0000;
        microcode[LDI][7] = 16'h0000;
        
        // JMP
        microcode[JMP][0] = CO_CODE | MI_CODE;
        microcode[JMP][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[JMP][2] = IO_CODE | J_CODE;
        microcode[JMP][3] = 16'h0000;
        microcode[JMP][4] = 16'h0000;
        microcode[JMP][5] = 16'h0000;
        microcode[JMP][6] = 16'h0000;
        microcode[JMP][7] = 16'h0000;
        
        // OUT
        microcode[OUT][0] = CO_CODE | MI_CODE;
        microcode[OUT][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[OUT][2] = AO_CODE | OI_CODE;
        microcode[OUT][3] = 16'h0000;
        microcode[OUT][4] = 16'h0000;
        microcode[OUT][5] = 16'h0000;
        microcode[OUT][6] = 16'h0000;
        microcode[OUT][7] = 16'h0000;
        
        // HLT
        microcode[HLT_INST][0] = CO_CODE | MI_CODE;
        microcode[HLT_INST][1] = RO_CODE | II_CODE | CE_CODE;
        microcode[HLT_INST][2] = HLT_CODE;
        microcode[HLT_INST][3] = 16'h0000;
        microcode[HLT_INST][4] = 16'h0000;
        microcode[HLT_INST][5] = 16'h0000;
        microcode[HLT_INST][6] = 16'h0000;
        microcode[HLT_INST][7] = 16'h0000;
    end
   
    wire [15:0] control_word;
    reg [2:0] t_state;
    assign control_word = microcode[opcode][t_state];
   
    assign HLT = control_word[15];
    assign MI  = control_word[14];
    assign RI  = control_word[13];
    assign RO  = control_word[12];
    assign IO  = control_word[11];
    assign II  = control_word[10];
    assign AI  = control_word[9];
    assign AO  = control_word[8];
    assign SUM = control_word[7];
    assign SU  = control_word[6];
    assign BI  = control_word[5];
    assign OI  = control_word[4];
    assign CE  = control_word[3];
    assign CO  = control_word[2];
    assign J   = control_word[1];
    
    always @(posedge clk or posedge clr) begin
        if (clr)
            t_state <= 3'd0;
        else if (!HLT)
            t_state <= t_state + 3'd1;
        end
endmodule
