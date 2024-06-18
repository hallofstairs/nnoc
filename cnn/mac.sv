module mac #(
    parameter DIM = 3,
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] a[DIM],
    input logic [DATA_WIDTH-1:0] b[DIM],
    input logic [DATA_WIDTH-1:0] c,  // Previous input

    output logic [DATA_WIDTH-1:0] out
);

  always_comb begin
    out = '0;
    foreach (a[i]) out += a[i] * b[i] + c;
  end

endmodule


