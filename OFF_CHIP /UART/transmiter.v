// UART Transmitter
module tx(input clk, rst, tx_en, wr_en,input [7:0] data_in,output reg tx_serial);
  reg [7:0] shift_reg;
  reg [3:0] bit_count;
  reg [1:0] state;

  parameter IDLE=0, START=1, DATA=2, STOP=3;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      tx_serial <= 1'b1; // idle line = high
      bit_count <= 0;
    end else begin
      case (state)
        IDLE: if (wr_en) begin
          shift_reg <= data_in;
          state <= START;
        end
        START: if (tx_en) begin
          tx_serial <= 1'b0; // start bit
          state <= DATA;
          bit_count <= 0;
        end
        DATA: if (tx_en) begin
          tx_serial <= shift_reg[0];
          shift_reg <= shift_reg >> 1;
          bit_count <= bit_count + 1;
          if (bit_count == 8) state <= STOP;
        end
        STOP: if (tx_en) begin
          tx_serial <= 1'b1; // stop bit
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
