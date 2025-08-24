`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:27:04
// Design Name: 
// Module Name: aludec
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



module aludec(
    input [5:0] funct,
    input [1:0] aluop,
    output reg [5:0] alucontrol // changed to 5 to accomodate all instructions
);
    always @(*) 
        case (aluop)
            2'b00: alucontrol = 6'b100000; // ADD (LW, SW, ADDI)
            2'b01: alucontrol = 6'b100010; // SUB (BEQ)
            2'b10: alucontrol = funct;               // R-type
               /* case (funct)
                    6'b100000: alucontrol = 3'b010; // ADD
                    6'b100010: alucontrol = 3'b110; // SUB
                    6'b100100: alucontrol = 3'b000; // AND
                    6'b100101: alucontrol = 3'b001; // OR
                    6'b101010: alucontrol = 3'b111; // SLT
                    default:   alucontrol = 3'bxxx; // Undefined funct
                endcase*/
        endcase
endmodule