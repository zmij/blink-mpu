`include "apb2_led.v"

`timescale 1ns / 1ps

module apb2_led_tb;

  localparam data_width = 32;
  localparam addr_width = 8;
  localparam strobe_count = data_width / 8;
  localparam tick = 2;

  reg clk = 0, rst_n = 0, enable, write;

  reg [addr_width - 1:0] addr;
  reg [data_width - 1:0] wdata;
  reg [strobe_count - 1:0] strb = {strobe_count{1'b1}};
  reg [2:0] prot = 0;
  reg sel;

  wire [data_width - 1:0] rdata;
  wire ready;
  wire slverr;

  wire led_state;


  apb2_led led_ (
      .pclk(clk),
      .preset_n(rst_n),
      .penable(enable),
      .pwrite(write),
      .paddr(addr),
      .pwdata(wdata),
      .pstrb(strb),
      .pprot(prot),
      .psel(sel),
      .prdata(rdata),
      .pready(ready),
      .pslverr(slverr),
      .led_state(led_state)
  );

  always #1 clk = ~clk;

  initial begin
    $dumpfile("apb2_led_tb");
    $dumpvars(0, apb2_led_tb);

    write = 0;

    #tick;

    rst_n = 1;

    $display("Write value");
    // setup phase
    write = 1;
    addr  = 0;
    wdata = 'b1;
    sel   = 1;

    #tick;
    // access phase
    enable = 1;

    #tick;

    enable = 0;
    write = 0;
    sel = 0;

    #tick;

    $display("Read value");
    // setup phase
    write = 0;
    addr  = 0;
    sel   = 1;

    #tick;
    // access phase
    enable = 1;

    #tick;

    enable = 0;
    write = 0;
    sel = 0;

    #tick;

    $display("Write value");
    // setup phase
    write = 1;
    addr  = 0;
    wdata = 'b0;
    sel   = 1;

    #tick;
    // access phase
    enable = 1;

    #tick;

    enable = 0;
    write = 0;
    sel = 0;

    #tick;

    $finish;
  end


endmodule
