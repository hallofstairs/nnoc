// NNoC testbench

module nnoc_tb;
  logic clk, reset;

  nnoc main (
      .clk  (clk),
      .reset(reset)
  );

  always #1 clk = ~clk;  // Set clock tick

  task automatic reset_cpu;
    begin
      reset = 1;
      #2 reset = 0;
    end
  endtask

  // Run simulation
  initial begin
    clk = 0;

    // Logging
    $dumpfile("build/waveform.vcd");
    $dumpvars(0, cpu_tb);

    reset_cpu();
    test_rv32i_base_int();

    // reset_cpu();
    // test_case_2();

    // TODO: Add more test cases

    #100;
    $finish;
  end


endmodule
