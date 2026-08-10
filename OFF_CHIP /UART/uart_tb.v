module uart_tb;

reg clk;
reg rst;
reg en;
reg [7:0] data_in;
wire [7:0] data_out;

uart_top dut (.clk(clk),.rst(rst),.en(en),.data_in(data_in),.data_out(data_out));

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin
    rst = 1;
    en = 0;
   data_in = 8'h00;

    #100;
    rst = 0;

    #20;
 data_in = 8'hA5;
  en = 1;
    #20;
  
    en = 0;
  
  

    #2_000_000;
    
   #20;
 data_in = 8'hA6;
  en = 1;
    #20;
  
    en = 0;
  
  

     #2_000_000;


    $display("================================");
  $display("data_in  = %d", data_in);
  $display("data_out = %d", data_out);

    if (data_in == data_out)
        $display("UART TEST PASSED");
    else
        $display("UART TEST FAILED");

    $display("================================");

    $finish;
end

initial begin
    $dumpfile("UART.vcd");
    $dumpvars(0, uart_tb);
end

endmodule
