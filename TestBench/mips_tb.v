`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:35:02
// Design Name: 
// Module Name: mips_tb
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


module mips_tb;

  reg clk, reset;
  wire [31:0] pc, instr;
  wire memwrite;
  wire [31:0] aluout, writedata, readdata;

  // Instantiate MIPS processor
  mips uut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instr(instr),
    .memwrite(memwrite),
    .aluout(aluout),
    .writedata(writedata),
    .readdata(readdata)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Instruction Memory (assumed interface)
  InstructionMemory imem (
    pc,instr
  );

  // Data Memory (your module)
  DataMemory dmem (
    .CLK(clk),
    .A(aluout[7:2]),     // Word-aligned address (6 bits)
    .WE(memwrite),
    .WD(writedata),
    .RD(readdata)
  );

  // Simulation control
  initial begin
    reset = 1;
    #15 reset = 0;

    $display("Time | PC   | Instr        | ALUOut     | WriteData  | MemWrite | ReadData");
    $monitor("%4dns | %h | %h | %h | %h |    %b     | %h",
             $time, pc, instr, aluout, writedata, memwrite, readdata);

    #200 $finish;
  end

endmodule
