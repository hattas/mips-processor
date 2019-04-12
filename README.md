# COEN 4710 Project 2 - VHDL Components
Spring 2019<br>
Due: April 18, 2019

### About
In this project we create the building blocks to support a modified subset of the MIPS 32-bit ISA.

We use VHDL to describe and Vivado to test each component.


### Authors
Kyle Change, John Hattas, and Patrick Woodford

### MIPS subset
**R-Type**: ADD, SUB, AND, OR, SLL, SRL, SLT, JR<br>
**I-Type**: ADDI, ORI, LUI, LW, SW, BEQ<br>
**J-Type** JAL

### Components
- Register File
  - 32 registers of 32 bits
- ALU and ALU Control
- 32 bit adder
- Memory unit
  - 64x32 SRAM
- Control unit
  - generates control signals from opcode
