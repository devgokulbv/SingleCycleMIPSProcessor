`timescale 1ns / 1ps

module datapath_tb;

  // Inputs
  reg clk, reset;
  reg memtoreg, pcsrc;
  reg alusrc, regdst;
  reg regwrite, jump;
  reg [2:0] alucontrol;
  reg [31:0] instr, readdata;

  // Outputs
  wire zero;
  wire [31:0] pc, aluout, writedata;

  // Instantiate the DUT
  datapath uut (
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
    .readdata(readdata)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Test sequence
  initial begin
    $display("Starting datapath testbench...");
    
    // Reset
    reset = 1;
    #10;
    reset = 0;

    // Simulate an R-type instruction: ADD $t1, $t2, $t3
    // opcode = 0, rs = 10, rt = 11, rd = 9, shamt = 0, funct = 32
    instr = 32'b000000_01010_01011_01001_00000_100000; // ADD
    regwrite = 1;
    regdst = 1;
    alusrc = 0;
    memtoreg = 0;
    pcsrc = 0;
    jump = 0;
    alucontrol = 3'b010; // ADD

    readdata = 32'h00000000; // Not used in R-type
    #20;

    // Simulate a load instruction: LW $t0, 4($t1)
    // opcode = 35, rs = 9, rt = 8, immediate = 4
    instr = 32'b100011_01001_01000_0000000000000100; // LW
    regwrite = 1;
    regdst = 0;
    alusrc = 1;
    memtoreg = 1;
    pcsrc = 0;
    jump = 0;
    alucontrol = 3'b010; // ADD for address calc

    readdata = 32'hCAFEBABE; // Simulated memory read
    #20;

    // Simulate a branch instruction: BEQ $t0, $t1, offset
    // opcode = 4, rs = 8, rt = 9, offset = 1
    instr = 32'b000100_01000_01001_0000000000000001; // BEQ
    regwrite = 0;
    regdst = 0;
    alusrc = 0;
    memtoreg = 0;
    pcsrc = 1; // Assume zero is set
    jump = 0;
    alucontrol = 3'b110; // SUB for BEQ

    readdata = 32'h00000000;
    #20;

    // Simulate a jump instruction: J 0x00000004
    instr = 32'b000010_00000000000000000000000100; // J
    regwrite = 0;
    jump = 1;
    #20;

    $display("Final PC = %h", pc);
    $display("ALU Output = %h", aluout);
    $display("Write Data = %h", writedata);
    $display("Zero Flag = %b", zero);

    $finish;
  end

endmodule