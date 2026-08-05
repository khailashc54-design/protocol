module uart_top(input clk,rst,en,input[7:0]data_in,output[7:0]data_out);
    wire tx_en;
    wire rx_en;
    wire tx_wire;
  uart_baud baud_gen (.clk(clk),.rst(rst),.tx_en(tx_en),.rx_en(rx_en));
  tx transmitter (.clk(clk),.rst(rst),.tx_en(tx_en),.wr_en(en),.data_in(data_in),.tx_serial(tx_wire));
  rx receiver (.clk(clk),.rst(rst),.rx_en(rx_en),.rx_serial(tx_wire),.data_out(data_out));
endmodule    
