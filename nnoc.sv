module nnoc (
    input  logic clk,
    input  logic usr_btn,
    output logic rgb_led0_r,
    output logic rgb_led0_g,
    output logic rgb_led0_b,
    output logic rst_n
);
  reg [26:0] counter = 0;

  // Increment the register by 1 each clock tick
  always_ff @(posedge clk) counter <= counter + 1;

  // Output inverted values of counter onto LEDs
  assign rgb_led0_r = ~counter[24];
  assign rgb_led0_g = ~counter[25];
  assign rgb_led0_b = 1;

  // Reset logic on button press
  reg reset_sr = 1'b1;
  always_ff @(posedge clk) reset_sr <= usr_btn;

  assign rst_n = reset_sr;

endmodule
