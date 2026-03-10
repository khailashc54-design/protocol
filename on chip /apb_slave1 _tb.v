//`include "apb_top.v"

module apb_top_tb;

reg pclk;
reg rst;
reg transfer;
reg pwrite;

reg [15:0] addr;
reg [15:0] wdata;

wire psel;
wire penable;
wire [15:0] paddar;
wire [15:0] pwdata;

apb_top dut(
  .pclk(pclk),
  .rst(rst),
  .transfer(transfer),
  .pwrite(pwrite),
  .addr(addr),
  .wdata(wdata),
  .psel(psel),
  .penable(penable),
  .paddar(paddar),
  .pwdata(pwdata)
);

initial pclk = 0;
always #5 pclk = ~pclk;

initial
begin
  $dumpfile("out_apb.vcd");
  $dumpvars(0,apb_top_tb);

  $monitor("t=%0t rst=%b transfer=%b psel=%b penable=%b addr=%h data=%h",
           $time,rst,transfer,psel,penable,addr,wdata);

  rst = 1;
  transfer = 0;
  pwrite = 0;
  addr = 0;
  wdata = 0;

  #10 rst = 0;

  #10 transfer = 1;
      pwrite = 1;
      addr = 16'h0010;
      wdata = 16'hAAAA;

  #10 transfer = 1;
      pwrite = 0;
      addr = 16'h0010;
      wdata = 16'hAAAA;
  #10 transfer =0;
  

  #100 $finish;

end

endmodule
