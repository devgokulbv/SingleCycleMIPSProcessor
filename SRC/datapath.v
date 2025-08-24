`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:18:02
// Design Name: 
// Module Name: datapath
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


module datapath(
        input clk,reset,
        input memtoreg, pcsrc,
        input alusrc,regdst,
        input regwrite,jump,
        input [5:0] alucontrol,
        output zero,
        output [31:0] pc,
        input [31:0] instr,
        output [31:0] aluout, writedata,
        input [31:0] readdata,
        input [4:0] shamt

    );
    wire [4:0]  writereg;
    wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
    wire [31:0] signimm, signimmsh,ZeroImm;
    wire [31:0] srca, srcb;
    wire [31:0] result;
    
    //Next PC Logic
    flopr #(32) pcreg(clk,reset,pcnext,pc);
    //Next Instruction , +4
    adder pcadd1(pc,32'b100,pcplus4);
    //For PC Branch
    sl2 immsh(signimm, signimmsh);
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(32) pcbrmux(pcplus4,pcbranch,pcsrc,pcnextbr);
    mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28],instr[25:0], 2'b00},jump, pcnext);
    //clk,E, a1,a2,a3,data,rd1,rd2
    RegisterFile rf(clk, regwrite, instr[25:21],instr[20:16], writereg,result, srca, writedata);
    mux2 #(5) wrmux(instr[20:16], instr[15:11],regdst, writereg);
    mux2 #(32) resmux(aluout, readdata, memtoreg, result);
    signext se(instr[15:0], signimm);
    zeroimm ze(instr[15:0], ZeroImm);
    
    // ALU logic
    mux2 #(32) srcbmux(writedata, signimm, alusrc,srcb);
    ALU alu(srca, srcb, alucontrol,shamt,aluout, zero);
     
    
    
    
    
    
    
endmodule
