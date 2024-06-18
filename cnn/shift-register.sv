module shift_register #(
    parameter DATA_WIDTH = 32,
    parameter SIZE = 4
) (
    input logic clk,
    input logic rst,
    input logic [DATA_WIDTH-1:0] i_data,
    output logic [DATA_WIDTH-1:0] o_data
);

  reg [DATA_WIDTH-1:0] sr[SIZE];

  always_ff @(posedge clk) begin


  end

endmodule
