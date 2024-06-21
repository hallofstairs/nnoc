module log_reg #(
    parameter NUM_FEATURES = 4
) (
    input logic clk,
    input logic rst_n,  // Active-low reset
    input logic start,

    input logic [31:0] features[NUM_FEATURES],
    output logic [31:0] prediction,
    output logic done
);
  // Model parameters
  logic [31:0] weights[NUM_FEATURES];
  logic [31:0] bias;

  // Internal signals
  logic [63:0] sum;  // Double width to prevent overflow
  logic [$clog2(NUM_FEATURES)-1:0] counter;

  // State machine
  enum logic [1:0] {
    IDLE,
    COMPUTE,
    SIGMOID
  } state;

  // Main sequential logic
  always_ff @(posedge clk) begin
    if (!rst_n) begin
      state <= IDLE;
      sum <= '0;
      counter <= '0;
      prediction <= '0;
      done <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          if (start) begin
            state <= COMPUTE;
            sum <= bias;  // Initialize sum w/ bias
            counter <= '0;
            done <= 1'b0;
          end
        end

        COMPUTE: begin
          if (counter < NUM_FEATURES) begin
            sum <= sum + features[counter] * weights[counter];
            counter <= counter + 1;
          end else state <= SIGMOID;
        end

        SIGMOID: begin
          if (sum[63]) prediction <= '0;  // If sum < 0, sigmoid = 0
          else if (sum > {63{1'b1}}) prediction <= {63{1'b1}};  // If sum > max, sigmoid = 1
          else prediction <= '0;  // TODO: Implement sigmoid function
        end
      endcase
    end
  end



endmodule
