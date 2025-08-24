`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:00:47
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input [5:0] A,
    output [31:0] RD
);
    reg [31:0] InsMem[0:63];

    initial begin
        // ADDI $2, $0, 5
        InsMem[0] = 32'h20020005;
        InsMem[4] = 32'h2003000c;
        InsMem[8] = 32'h2067fff7;
        InsMem[12] = 32'h00e22025;
        InsMem[16] = 32'h8c020000;
        InsMem[20] = 32'h20020005;
    end

    assign RD = InsMem[A];
endmodule