`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:31:28
// Design Name: 
// Module Name: controller
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


module controller(
    input [5:0] op, funct,
    input zero,
    output memtoreg, memwrite,
    output pcsrc, alusrc,
    output regdst, regwrite,
    output jump,
    output [5:0] alucontrol,
    input [4:0] shamt
);
    wire [1:0] aluop;
    wire branch;

    // Main decoder
    maindec md(
        .op(op),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .aluop(aluop)
    );

    // ALU decoder
    aludec ad(
        .funct(funct),
        .aluop(aluop),
        .alucontrol(alucontrol)
    );

    // Branch decision logic
    assign pcsrc = branch & zero;
endmodule
