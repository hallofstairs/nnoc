`include "./usb/usb-serial-ctrl-ep.sv"

parameter PRESCALE = 51;
parameter DATA_WIDTH = 8;

module nnoc (
    input logic clk,
    input logic rst_n, // Active-low reset

    inout  logic usb_d_p,    // USB D+
    inout  logic usb_d_n,    // USB D-
    output logic usb_pullup  // Tell host there's USB connected
);

  // USB core signals
  logic       usb_p_tx;
  logic       usb_n_tx;
  logic       usb_p_rx;
  logic       usb_n_rx;
  logic       usb_tx_en;
  logic [7:0] uart_tx_data;
  logic       uart_tx_valid;
  logic       uart_tx_ready;
  logic [7:0] uart_rx_data;
  logic       uart_rx_valid;
  logic       uart_rx_ready;

  // Instantiate USB core
  usb_serial_ctrl_ep #(
      .PIN_USB_P("N1"),
      .PIN_USB_N("M2")
  ) usb_serial_ctrl_ep_inst (
      .clk  (clk),
      .reset(~rst_n),

      // USB pins
      .pin_usb_p(usb_d_p),
      .pin_usb_n(usb_d_n),

      // USB signals
      .usb_p_tx,
      .usb_n_tx,
      .usb_p_rx,
      .usb_n_rx,
      .usb_tx_en,

      // UART interface
      .uart_tx_data,
      .uart_tx_valid,
      .uart_tx_ready,
      .uart_rx_data,
      .uart_rx_valid,
      .uart_rx_ready
  );

endmodule


