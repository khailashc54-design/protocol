module uart_tb;
  reg clk,rst,en;
  reg [7:0]data_in;
 wire [7:0]data_out;
  uart_top dut(.clk(clk),.rst(rst),.en(en),.data_in(data_in),.data_out(data_out));
  initial begin
    clk=1'b0;
    forever #2 clk=~clk;
  end 
  initial begin
    rst=1;en=0;data_in=8'b11111111;
    #5 rst=0;
   #2 en=1;
   #10000000$finish;
  end 
  initial begin
    $dumpfile("UART.vcd");
    $dumpvars(1,uart_tb);
  end
  initial begin
    $monitor("Time=%0t rst=%b en=%b data_in=%d data_out=%d",
              $time,rst,en,data_in,data_out);
end
endmodule 
