`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:03:03
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input         CLK,  // Clock signal rising edge
    input   [5:0] A,    // Address for 64 locations
    input         WE,   // Write Enable 1: Write 0: no write
    input  [31:0] WD,   // 32-bit data in
    output [31:0] RD    // 32-bit read data
);

    reg [31:0] DataArr [63:0];   // Memory array

    // Preload first 10 elements with 10, 20, ..., 100
    integer i;
    initial begin
        for (i = 0; i < 10; i = i + 1) begin
            DataArr[i] = (i + 1) * 10;
        end
    end

    assign RD = DataArr[A];      // Read logic

    always @ (posedge CLK) begin
        if (WE)
            DataArr[A] <= WD;    // Write logic
    end

endmodule
