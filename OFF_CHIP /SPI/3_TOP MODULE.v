/ top module 
module spi_top(input [7:0] ma_datain,sa_datain,input clk,start,rst,output  [7:0] sa_dataout,ma_dataout);
  wire miso,mosi,cs,sclk;
  spi_master m1(.mdatain(ma_datain),.clk(clk),.rst(rst),.start(start),.miso(miso),.mdataout(ma_dataout),.sclk(sclk),.cs(cs),.mosi(mosi));
  spi_slave s1(.sdatain(sa_datain),.sclk(sclk),.rst(rst),.cs(cs),.sdataout(sa_dataout),.miso(miso),.mosi(mosi));
endmodule
