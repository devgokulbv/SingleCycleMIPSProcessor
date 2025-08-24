`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:01:29
// Design Name: 
// Module Name: InstructionMemory_tb
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



module InstructionMemory_tb;
    // Testbench signals
    reg [5:0] A;
    wire [31:0] RD;

    // Instantiate the InstructionMemory module
    InstructionMemory uut (
        .A(A),
        .RD(RD)
    );

    initial begin
        $display("Starting InstructionMemory Testbench...");
        
        // Test case 1: Read from address 0
        A = 6'd0;
        #10; // Wait for propagation

        $display("Address: %d, Instruction: %h", A, RD);
        if (RD == 32'h20020005)
            $display("PASS: Correct instruction read from memory.");
        else
            $display("FAIL: Incorrect instruction read.");

        $finish;
    end
endmodule