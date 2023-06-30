//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.9 Beta-1
//Part Number: GW1NSR-LV4CQN48PC7/I6
//Device: GW1NSR-4C
//Created Time: Thu Jun 22 16:17:14 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	gowin_empu_top your_instance_name(
		.sys_clk(sys_clk_i), //input sys_clk
		.uart0_rxd(uart0_rxd_i), //input uart0_rxd
		.uart0_txd(uart0_txd_o), //output uart0_txd
		.master_pclk(master_pclk_o), //output master_pclk
		.master_prst(master_prst_o), //output master_prst
		.master_penable(master_penable_o), //output master_penable
		.master_paddr(master_paddr_o), //output [7:0] master_paddr
		.master_pwrite(master_pwrite_o), //output master_pwrite
		.master_pwdata(master_pwdata_o), //output [31:0] master_pwdata
		.master_pstrb(master_pstrb_o), //output [3:0] master_pstrb
		.master_pprot(master_pprot_o), //output [2:0] master_pprot
		.master_psel1(master_psel1_o), //output master_psel1
		.master_prdata1(master_prdata1_i), //input [31:0] master_prdata1
		.master_pready1(master_pready1_i), //input master_pready1
		.master_pslverr1(master_pslverr1_i), //input master_pslverr1
		.reset_n(reset_n_i) //input reset_n
	);

//--------Copy end-------------------
