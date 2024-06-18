// 2-dimensional, single filter, parameter sharing CONV layer

`include "./mac.sv"

module conv #(
    parameter input_size  = 9'h009,
    parameter kernel_size = 9'h003,
    parameter stride      = 1,
    parameter padding     = 0,       // no padding rn
    parameter data_width  = 16,
    parameter frac_bits   = 12
) (
    input logic clk,
    input logic rst,

    input logic [data_width-1:0] i_volume [  input_size*input_size],
    input logic [data_width-1:0] i_weights[kernel_size*kernel_size],

    output logic [data_width-1:0] o_volume[input_size - kernel_size + (2 * padding)],
    output logic o_valid_conv,
    output logic o_end_conv
);

  // Lay out each filter operation
  generate
    genvar i;
    for (i = 0; i < kernel_size; i += 1) begin
      if ((i + 1) % kernel_size == 0) begin  // End of row
        if (i == kernel_size * kernel_size - 1) begin  // End of CONV
          // MAC with output set to o_volume
        end
      end else begin

      end
    end

  endgenerate

  always_ff @(posedge clk) begin : blockName

  end




endmodule
