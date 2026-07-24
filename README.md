# 8 Bit Computer

<table align="center">
  <tr>
    <td align="center" width="50%">
      <img src="https://github.com/user-attachments/assets/0f0a4d5e-8893-492d-9bd4-9d74882059ee" width="100%">
    </td>
    <td align="center" width="50%">
      <img src="https://github.com/user-attachments/assets/257883b5-02cb-46cb-a38b-91ad016f9674" width="100%">
    </td>
  </tr>
</table>

# About
This project is my attempt at recreating Ben Eater's SAP-1 8 bit breadboard computer. This computer implements computer hardware including registers, ALU, RAM, I/O bus, display, CPU, and clock/control logic using discrete ICs. While more simple and less impressive than computers nowadays, this computer demonstrates many of the same fundamental concepts found in modern processors and provides a modular design that can be easily expanded on for future designs. In addition, I implemented this computer on an FPGA and added notable improvements to the design. 

I highly recommend for anybody interested in electronics or computers to check out Ben Eater and his [YouTube channel](https://www.youtube.com/@BenEater/featured), there is a lot of really interesting videos and playlists dedicated to teaching people how computers work at the gate level, various computer projects and experiments, and other topics including networking, digital electronics, and more!

# Physical Hardware Design
## SAP-1 Architecture
<img width="720" height="600" alt="image" src="https://github.com/user-attachments/assets/a156d487-a3d1-4b97-9c67-911a08165c6c" />

Here is a high-level diagram of the SAP-1 architecture that makes up the 8-bit computer. Meant to be Simple As Possible (SAP), it is a very valuable educational design that implements the most crucial parts needed for a computer.

The parts of the computer are:

| Component | Description |
|------------|-------------|
| **Program Counter (PC)** | Stores the address of the next instruction to be fetched and increments after each instruction. |
| **Memory Address Register (MAR)** | Holds the memory address used to access RAM. |
| **Random Access Memory (RAM)** | Stores both program instructions and data in memory. |
| **Instruction Register (IR)** | Stores the current instruction. |
| **Control Unit** | Decodes instructions and generates the control signals that coordinate CPU execution. |
| **Accumulator (A Register)** | Stores operands and intermediate results for arithmetic operations. |
| **Arithmetic Logic Unit (ALU)** | Performs 8-bit addition and subtraction operations. |
| **B Register** | Holds the second operand supplied to the ALU during arithmetic operations. |
| **Output Register** | Stores the final result before it is sent to the display to be displayed in decimal. |

## Schematics
Refer to [Ben Eater's website ](https://eater.net/8bit/schematics) where you can find detailed schematics for each part of the computer. As well as see a complete parts list for the build.

## SAP-1 Instruction Set Architecture (ISA) 
The stock design is able to perform basic operations including:

| Instruction | Description |
|------------|-------------|
| **NOP** | No operation |
| **LDA** | Load data from RAM into A register |
| **ADD** | Add contents of A and B register |
| **SUB** | Subtract contents of A and B register |
| **STA** | Store data from A register into RAM |
| **LDI** | Load immediate a value|
| **OUT** | Displays value currently on data bus|
| **JMP** | Jump command |
| **JC** | Jump carry command |
| **JZ** | Jump zero command |

# Breadboard Implementation
After many hours of tinkering, watching videos, and debugging, the end result was a solid 8-bit computer that really taught me a lot about digital logic and for designing a computer from the ground up.

<p align="center">
  <img src="https://github.com/user-attachments/assets/0f0a4d5e-8893-492d-9bd4-9d74882059ee" width="40%">
</p>

# Python Based Assembler
In an effort to use a dedicated EEPROM programmer for the CPU microcode, I implemented a python script to generate a BIN file that can be then loaded into your EEPROM programmer. I moved away from an Arduino based EEPROM programmer because there were consistent bit errors during programming, but I included that original code in the repo for reference. For the python based BIN creater scripts, due to avaliability, I used a 28C16 EEPROM for the display and dual 28C64 EEPROM for the CPU microcode. Feel free to try both the Arduino programmer and python programmer to see which one you like best.

# Verilog Implementation
Also included in this repo is a Verilog implementation for use on an FPGA. This in itself was a lot more reliable than the breadboard implementation because the computer is not fighting breadboard capacitance that cause noise. The FPGA implementation also allows you to add in new hardware that would not be feasible without a major redesign on the breadboard implementation.

## Example With Simulation and Hardware
Shown below is the timing diagram of a simple program:
```bash
LDI 3  // Load immediate 3 into register A
STA 15 // Store that 3 into byte 15 of RAM
LDI 0  // Load immediate 0 into register A
ADD 15 // Add 3 stored in RAM with 0 in register A
OUT    // Output result of 3
```

You can observe that as certain computer functions are being executed, data is being moved around to different parts of the computer to eventually be outputted to the out_reg in the end. For this implementation, the architecture is being ran on the Diligent Basys 3 FPGA board.

<img width="2213" height="1167" alt="image" src="https://github.com/user-attachments/assets/31bcdf33-8c83-453d-bad9-e5b28bbbdd03" />

<img width="3024" height="2006" alt="IMG_7687" src="https://github.com/user-attachments/assets/257883b5-02cb-46cb-a38b-91ad016f9674" />

# Notable Design Improvements
As I document my design changes, I will update this section.

# Conclusion
This project is my attempt at recreating Ben Eater's SAP-1 8 bit breadboard computer. I highly recommend for anybody interested in electronics or computers to check out Ben Eater and his [YouTube channel](https://www.youtube.com/@BenEater/featured), the level of detail is amazing and I truly believe can show even beginners topics on computers and digital electronics.
