`ifndef __DUMMY_RAM_V__
`define __DUMMY_RAM_V__

module dummy_apb2_ram (
    clk,
    rst_n,
    enable,
    write,
    addr,
    wdata,
    strb,
    prot,
    sel,
    rdata,
    ready,
    slverr
);
  parameter data_width = 32;
  parameter addr_width = 8;

  localparam strobe_count = data_width / 8;

  input clk, rst_n, enable, write;
  input [addr_width - 1:0] addr;
  input [data_width - 1:0] wdata;
  input [strobe_count - 1:0] strb;
  input [2:0] prot;
  input sel;

  output reg [data_width - 1:0] rdata;
  output reg ready;
  output reg slverr;

  localparam idle_state = 2'b00;
  localparam w_enable = 2'b01;
  localparam r_enable = 2'b10;

  reg [data_width - 1:0] ram_[0:2**addr_width - 1];
  reg [1:0] state_;

  always @(negedge rst_n or posedge clk) begin
    if (rst_n == 0) begin
      state_ <= idle_state;
      rdata  <= {data_width{1'bx}};
      ready  <= 0;
      slverr <= 0;
    end else begin
      case (state_)
        idle_state: begin
          rdata <= {data_width{1'bx}};
          ready <= 0;
          if (sel) begin
            if (write) state_ <= w_enable;
            else state_ <= r_enable;
          end
        end
        w_enable: begin
          if (sel && write) begin
            ram_[addr] <= wdata;
            ready <= 1;
          end
          state_ = idle_state;
        end
        r_enable: begin
          if (sel && !write) begin
            rdata <= ram_[addr];
            ready <= 1;
          end
          state_ = idle_state;
        end
        default: begin
          state_ <= idle_state;
        end
      endcase
    end
  end

endmodule

`endif  // __DUMMY_RAM_V__
