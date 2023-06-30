// gowin_empu_top your_instance_name(
// 	.sys_clk(sys_clk_i), //input sys_clk
// 	.uart0_rxd(uart0_rxd_i), //input uart0_rxd
// 	.uart0_txd(uart0_txd_o), //output uart0_txd
// 	.master_pclk(apb_pclk_o), //output master_pclk
// 	.master_prst(apb_prst_o), //output master_prst
// 	.master_penable(apb_penable_o), //output master_penable
// 	.master_paddr(apb_paddr_o), //output [7:0] master_paddr
// 	.master_pwrite(apb_pwrite_o), //output master_pwrite
// 	.master_pwdata(apb_pwdata_o), //output [31:0] master_pwdata
// 	.master_pstrb(apb_pstrb_o), //output [3:0] master_pstrb
// 	.master_pprot(apb_pprot_o), //output [2:0] master_pprot
// 	.master_psel1(apb_psel1_o), //output master_psel1
// 	.master_prdata1(apb_prdata1_i), //input [31:0] master_prdata1
// 	.master_pready1(apb_pready1_i), //input master_pready1
// 	.master_pslverr1(apb_pslverr1_i), //input master_pslverr1
// 	.reset_n(reset_n_i) //input reset_n
// );

`include "gowin_pllvr/gowin_pllvr.v"
`include "gowin_empu/gowin_empu.v"
`include "apb2_led.v"

module top (
    clk_in,
    reset_n_i,

    uart0_rxd,
    uart0_txd,
    led_o
);

  parameter clk_freq = 27_000_000;

  input clk_in, reset_n_i;
  input uart0_rxd;
  output uart0_txd;

  output led_o;

  wire clk_x2;

  gowin_pllvr pllvr (
      .clkin (clk_in),  //input clkin
      .clkout(clk_x2)   //output clkout
  );

  wire apb_pclk_o, apb_prst_o, apb_penable_o, apb_pwrite_o;
  wire [7:0] apb_paddr_o;
  wire [3:0] apb_pstrb_o;
  wire [2:0] apb_pprot_o;
  wire [31:0] apb_pwdata_o, apb_prdata1_i;

  wire apb_psel1_o, apb_pready1_i, apb_pslverr1_i;


  gowin_empu_top empu (
      .sys_clk(clk_x2),  //input sys_clk
      .uart0_rxd(uart0_rxd),  //input uart0_rxd
      .uart0_txd(uart0_txd),  //output uart0_txd

      .master_pclk(apb_pclk_o),  //output master_pclk
      .master_prst(apb_prst_o),  //output master_prst
      .master_penable(apb_penable_o),  //output master_penable
      .master_paddr(apb_paddr_o),  //output [7:0] master_paddr
      .master_pwrite(apb_pwrite_o),  //output master_pwrite
      .master_pwdata(apb_pwdata_o),  //output [31:0] master_pwdata
      .master_pstrb(apb_pstrb_o),  //output [3:0] master_pstrb
      .master_pprot(apb_pprot_o),  //output [2:0] master_pprot

      .master_psel1(apb_psel1_o),  //output master_psel1
      .master_prdata1(apb_prdata1_i),  //input [31:0] master_prdata1
      .master_pready1(apb_pready1_i),  //input master_pready1
      .master_pslverr1(apb_pslverr1_i),  //input master_pslverr1

      .reset_n(reset_n_i)  //input reset_n
  );

  apb2_led leds (
      .pclk(apb_pclk_o),
      .preset_n(apb_prst_o),
      .penable(apb_penable_o),
      .paddr(apb_paddr_o),
      .pwrite(apb_pwrite_o),
      .pwdata(apb_pwdata_o),
      .pstrb(apb_pstrb_o),
      .pprot(apb_pprot_o),

      .psel(apb_psel1_o),
      .prdata(apb_prdata1_i),
      .pready(apb_pready1_i),
      .pslverr(apb_pslverr1_i),
      .led_state(led_o)
  );


endmodule
