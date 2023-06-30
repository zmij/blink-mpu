`ifndef __APB2_LED_V__
`define __APB2_LED_V__

/**
 * Simple module for driving a led via APB2 bus
 */
module apb2_led (
    pclk,
    preset_n,
    penable,
    pwrite,
    paddr,
    pwdata,
    pstrb,
    pprot,
    psel,
    prdata,
    pready,
    pslverr,
    led_state
);
  parameter data_width = 32;
  parameter addr_width = 8;
  parameter led_count = 1;
  localparam strobe_count = data_width / 8;

  input pclk, preset_n, penable, pwrite;
  input [addr_width - 1:0] paddr;
  input [data_width - 1:0] pwdata;
  input [strobe_count - 1:0] pstrb;
  input [2:0] pprot;

  input psel;

  output reg [data_width - 1:0] prdata;
  output reg pready;
  output reg pslverr;
  output reg [led_count - 1:0] led_state;

  localparam idle_state = 2'b00;
  localparam w_enable = 2'b01;
  localparam r_enable = 2'b10;

  reg [1:0] state_;

  always @(negedge preset_n or posedge pclk) begin
    if (preset_n == 0) begin
      state_ <= idle_state;
      prdata <= {data_width{1'bz}};
      pready <= 0;
      pslverr <= 0;
      led_state <= 0;
    end else begin
      case (state_)
        idle_state: begin
          prdata <= {data_width{1'bz}};
          pready <= 0;
          if (psel) begin
            if (pwrite) state_ <= w_enable;
            else state_ <= r_enable;
          end
        end
        w_enable: begin
          if (psel && pwrite) begin
            if (paddr == 0) begin
              led_state <= pwdata[led_count-1:0];
              pready <= 1;
            end else begin
              pslverr <= 1;
              pready  <= 1;
            end
          end
          state_ = idle_state;
        end
        r_enable: begin
          if (psel && !pwrite) begin
            if (paddr == 0) begin
              prdata <= led_state;
              pready <= 1;
            end else begin
              pslverr <= 1;
              pready  <= 1;
            end
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

`endif  // __APB2_LED_V__
