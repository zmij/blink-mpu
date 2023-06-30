`include "dummy-ram.v"

`timescale 1ns / 1ps

module dummy_apb2_ram_tb;
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


  always #1 clk = ~clk;

  dummy_apb2_ram ram_ (
      .clk(clk),
      .rst_n(rst_n),
      .enable(enable),
      .write(write),
      .addr(addr),
      .wdata(wdata),
      .strb(strb),
      .prot(prot),
      .sel(sel),
      .rdata(rdata),
      .ready(ready),
      .slverr(slverr)
  );

  initial begin
    $dumpfile("dummy_apb2_ram_tb");
    $dumpvars(0, dummy_apb2_ram_tb);

    write = 0;

    #tick;

    rst_n = 1;

    $display("Write value");
    // setup phase
    write = 1;
    addr  = 'd13;
    wdata = 'd42;
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
    addr  = 'd13;
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
