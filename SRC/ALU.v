`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2025 09:18:09
// Design Name: 
// Module Name: ALU
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
/*
A&B     000
A |B    001
A+B     010
A-B     110
SLT     111
*/

module ALU(
    input [31:0] A, B,
    input [5:0] ALUControl,   // Expanded to 6 bits
    input [4:0] shamt,        // Shift amount for shift ops
    output reg [31:0] result,
    output ZeroFlag
);

    always @(*) begin
        case (ALUControl)
            6'b100000: result = A + B;             // ADD
            6'b100001: result = A + B;             // ADDU
            6'b100010: result = A - B;             // SUB
            6'b100011: result = A - B;             // SUBU
            6'b100100: result = A & B;             // AND
            6'b100101: result = A | B;             // OR
            6'b100110: result = A ^ B;             // XOR
            6'b100111: result = ~(A | B);          // NOR
            6'b101010: result = ($signed(A) < $signed(B)) ? 32'b1 : 32'b0; // SLT
            6'b000000: result = B << shamt;        // SLL
            6'b000010: result = B >> shamt;        // SRL
            6'b000011: result = $signed(B) >>> shamt; // SRA
            6'b000100: result = B << A[4:0];       // SLLV
            6'b000110: result = B >> A[4:0];       //SRLV
            6'b000111: result = $signed(B) >>> A[4:0];
            
            default:   result = 32'bx;             // Undefined
        endcase
    end

    assign ZeroFlag = (result == 32'b0);

endmodule
