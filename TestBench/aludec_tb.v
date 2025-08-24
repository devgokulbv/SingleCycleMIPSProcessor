`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:28:41
// Design Name: 
// Module Name: aludec_tb
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



module aludec_tb;

  // Inputs
  reg [5:0] funct;
  reg [1:0] aluop;

  // Output
  wire [2:0] alucontrol;

  // Instantiate the Unit Under Test (UUT)
  aludec uut (
    .funct(funct),
    .aluop(aluop),
    .alucontrol(alucontrol)
  );

  initial begin
    $display("Time | aluop | funct   | alucontrol");
    $monitor("%4dns |  %b   | %b |    %b", $time, aluop, funct, alucontrol);

    // Test LW/SW/ADDI (aluop = 00 → ADD)
    aluop = 2'b00; funct = 6'bxxxxxx; #10;

    // Test BEQ (aluop = 01 → SUB)
    aluop = 2'b01; funct = 6'bxxxxxx; #10;

    // R-type ADD
    aluop = 2'b10; funct = 6'b100000; #10;

    // R-type SUB
    aluop = 2'b10; funct = 6'b100010; #10;

    // R-type AND
    aluop = 2'b10; funct = 6'b100100; #10;

    // R-type OR
    aluop = 2'b10; funct = 6'b100101; #10;

    // R-type SLT
    aluop = 2'b10; funct = 6'b101010; #10;

    // R-type undefined funct
    aluop = 2'b10; funct = 6'b111111; #10;

    $finish;
  end

endmodule
