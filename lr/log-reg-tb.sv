`include "./log-reg.sv"
`timescale 1ns / 1ps

module log_reg_tb;

  parameter NUM_FEATURES = 4;

  logic clk;
  logic rst_n;
  logic [31:0] features[NUM_FEATURES];
  logic start;
  logic [31:0] prediction;
  logic done;

  log_reg #(
      .NUM_FEATURES(NUM_FEATURES)
  ) uut (
      .clk(clk),
      .rst_n(rst_n),
      .start(start),
      .features(features),
      .prediction(prediction),
      .done(done)
  );

  always #5 clk = ~clk;

  // // Test task
  // task run_test;
  //   input [31:0] test_features[NUM_FEATURES-1:0];
  //   input [31:0] expected_output;
  //   integer i;
  //   begin
  //     $display("Starting test with inputs:");
  //     for (i = 0; i < NUM_FEATURES; i = i + 1) $display("Feature %0d: %0d", i, test_features[i]);

  //     for (i = 0; i < NUM_FEATURES; i = i + 1) features[i] = test_features[i];

  //     start = 1;
  //     @(posedge clk);
  //     start = 0;
  //     @(posedge done);
  //     if (prediction == expected_output)
  //       $display("Test PASSED. Expected: %h, Got: %h", expected_output, prediction);
  //     else $display("Test FAILED. Expected: %h, Got: %h", expected_output, prediction);
  //     @(posedge clk);
  //   end
  // endtask

  // Run test

  initial begin
    $dumpfile("logistic_regression_tb.vcd");
    $dumpvars(0, log_reg_tb);
  end

endmodule
