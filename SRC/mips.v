`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:32:16
// Design Name: 
// Module Name: mips
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


module mips(
    input clk, reset,
    output [31:0] pc,
    input [31:0] instr,
    output memwrite,
    output [31:0] aluout, writedata,
    input [31:0] readdata
);
    wire memtoreg, branch;
    wire alusrc, regdst, regwrite, jump;
    wire [5:0] alucontrol;
    wire [4:0] shamt;
    wire pcsrc;
    wire zero;
    
    assign shamt = (instr[31:26] == 6'b000000) ? instr[10:6] : 5'b00000;

    
    // Control Unit
    controller c(
        .op(instr[31:26]),
        .funct(instr[5:0]),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .shamt(shamt)
    );

    // Datapath
    datapath dp(
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .zero(zero),
        .pc(pc),
        .instr(instr),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata),
        .shamt(shamt)
    );
endmodule