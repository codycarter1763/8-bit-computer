# 8 Bit Computer
<p align="center">
  <img src="https://github.com/user-attachments/assets/0f0a4d5e-8893-492d-9bd4-9d74882059ee" width="40%">
</p>

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

# Breadboard Implementation

# Python Based Assembler

# Verilog Implementation

# Notable Design Improvements

# Conclusion
