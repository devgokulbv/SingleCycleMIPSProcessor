`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 18:10:20
// Design Name: 
// Module Name: RegisterFile
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



module RegisterFile(
        input clk,WE3,
        input [4:0] A1,A2,A3,
        
        input [31:0] WD3,
        output [31:0] RD1,RD2
    );
    
    reg [31:0] RegFile[31:0];
    always @(posedge clk)
        if(WE3) RegFile[A3] <= WD3;
    assign RD1 = (A1 !=0 ) ? (RegFile[A1]) : 0;
    assign RD2 = (A2 !=0 ) ? (RegFile[A2]) : 0;
endmodule

