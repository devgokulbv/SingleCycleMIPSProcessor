`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:03:43
// Design Name: 
// Module Name: DataMemory_tb
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



`timescale 1ns / 1ps

module DataMemory_tb;

    // Testbench signals
    reg CLK;
    reg [5:0] A;
    reg WE;
    reg [31:0] WD;
    wire [31:0] RD;

    // Instantiate the DataMemory module
    DataMemory uut (
        .CLK(CLK),
        .A(A),
        .WE(WE),
        .WD(WD),
        .RD(RD)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10ns clock period
    end

    // Test sequence
    initial begin
        // Wait for initialization
        #10;

        WE = 0;  // Disable write

        // Read and display first 10 memory locations
        $display("Reading initialized memory values:");
        for (A = 0; A < 10; A = A + 1) begin
            #10;  // Wait for read to settle
            $display("Address %0d: Data = %0d", A, RD);
        end

        $finish;
    end

endmodule