`include "usb/uart_rx.sv"
`include "usb/uart_tx.sv"

/*
 * AXI4-Stream UART
 */
module uart #(
    parameter DATA_WIDTH = 8
) (
    input wire clk,
    input wire rst,

    /*
     * AXI input
     */
    input  wire [DATA_WIDTH-1:0] i_data,
    input  wire                  i_valid,
    output wire                  i_ready,

    /*
     * AXI output
     */
    output wire [DATA_WIDTH-1:0] o_data,
    output wire                  o_valid,
    input  wire                  o_ready,

    /*
     * UART interface
     */
    input  wire rxd,
    output wire txd,

    /*
     * Status
     */
    output wire tx_busy,
    output wire rx_busy,
    output wire rx_overrun_error,
    output wire rx_frame_error,

    /*
     * Configuration
     */
    input wire [15:0] prescale

);

  uart_tx #(
      .DATA_WIDTH(DATA_WIDTH)
  ) uart_tx_inst (
      .clk(clk),
      .rst(rst),
      // axi input
      .s_axis_tdata(s_axis_tdata),
      .s_axis_tvalid(s_axis_tvalid),
      .s_axis_tready(s_axis_tready),
      // output
      .txd(txd),
      // status
      .busy(tx_busy),
      // configuration
      .prescale(prescale)
  );

  uart_rx #(
      .DATA_WIDTH(DATA_WIDTH)
  ) uart_rx_inst (
      .clk(clk),
      .rst(rst),
      // axi output
      .m_axis_tdata(m_axis_tdata),
      .m_axis_tvalid(m_axis_tvalid),
      .m_axis_tready(m_axis_tready),
      // input
      .rxd(rxd),
      // status
      .busy(rx_busy),
      .overrun_error(rx_overrun_error),
      .frame_error(rx_frame_error),
      // configuration
      .prescale(prescale)
  );

endmodule
