

`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg [31:0] A, B;
    reg [2:0] ALUControl;

    // Outputs
    wire [31:0] result;
    wire ZeroFlag;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .result(result),
        .ZeroFlag(ZeroFlag)
    );

    initial begin
        $display("Starting ALU Testbench...");
        
        // Test AND
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F; ALUControl = 3'b000;
        #10 $display("AND: result = %h, ZeroFlag = %b", result, ZeroFlag);

        // Test OR
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F; ALUControl = 3'b001;
        #10 $display("OR : result = %h, ZeroFlag = %b", result, ZeroFlag);

        // Test ADD
        A = 32'd15; B = 32'd10; ALUControl = 3'b010;
        #10 $display("ADD: result = %d, ZeroFlag = %b", result, ZeroFlag);

        // Test SUB
        A = 32'd15; B = 32'd15; ALUControl = 3'b110;
        #10 $display("SUB: result = %d, ZeroFlag = %b", result, ZeroFlag);

        // Test SLT
        A = 32'd10; B = 32'd11; ALUControl = 3'b111;
        #10 $display("SLT: result = %d, ZeroFlag = %b", result, ZeroFlag);

        $display("ALU Testbench Completed.");
        $finish;
    end

endmodule