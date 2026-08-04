module uart_baud (input clk,rst,output tx_en,rx_en);
  reg [12:0]count_tx;
  reg[9:0]count_rx;
  always@(posedge clk)begin
    if(rst)begin
      count_tx<=0;
      count_rx<=0;
    end
    else begin
      if(count_tx==5208)
        count_tx<=0;
      else
        count_tx<=count_tx+1;
    end
  end
  always@(posedge clk)begin
    if(rst)begin
      count_rx<=0;
    end
    else begin
      if(count_rx==325)
        count_rx<=0;
      else
        count_rx<=count_rx+1;
    end
  end
  assign tx_en=(count_tx==0)?1'b1:1'b0;
  assign rx_en=(count_rx==0)?1'b1:1'b0;
endmodule
