`timescale 1ns / 1ps

module RegisterFile_tb;

  // Inputs
  reg clk;
  reg WE3;
  reg [4:0] A1, A2, A3;
  reg [31:0] WD3;

  // Outputs
  wire [31:0] RD1, RD2;

  // Instantiate the DUT
  RegisterFile uut (
    .clk(clk),
    .WE3(WE3),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .WD3(WD3),
    .RD1(RD1),
    .RD2(RD2)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Test sequence
  initial begin
    $display("Starting RegisterFile Testbench...");
    
    // Initialize inputs
    WE3 = 0; A1 = 0; A2 = 0; A3 = 0; WD3 = 0;
    #10;

    // Write to register 5
    WE3 = 1;
    A3 = 5;
    WD3 = 32'hDEADBEEF;
    #10;

    // Disable write
    WE3 = 0;
    #10;

    // Read from register 5
    A1 = 5;
    A2 = 5;
    #10;

    // Display results
    $display("RD1 = %h, RD2 = %h", RD1, RD2);

    // Check correctness
    if (RD1 == 32'hDEADBEEF && RD2 == 32'hDEADBEEF)
      $display("✅ Test Passed");
    else
      $display("❌ Test Failed");

    $finish;
  end

endmodule