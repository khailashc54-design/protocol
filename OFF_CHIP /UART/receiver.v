// UART Receiver
module rx(input clk, rst, rx_en, rx_serial,output reg [7:0] data_out);
  reg [7:0] shift_reg;
  reg [3:0] bit_count;
  reg [1:0] state;

  parameter IDLE=0, START=1, DATA=2, STOP=3;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      bit_count <= 0;
      shift_reg <= 0;
    end else begin
      case (state)
        IDLE: if (rx_serial == 0) state <= START; // detect start bit
        START: if (rx_en) state <= DATA;
        DATA: if (rx_en) begin
          shift_reg <= {rx_serial,shift_reg[7:1]};
          bit_count <= bit_count + 1;
          if (bit_count == 8) state <= STOP;
        end
        STOP: if (rx_en) begin
          if (rx_serial == 1) data_out <= shift_reg; // valid stop bit
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
