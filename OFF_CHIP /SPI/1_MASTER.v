module spi_master (input clk,rst,en,miso,input [7:0]mdatain,output reg cs,sclk,mosi);
  reg [7:0]shift;
  reg[1:0]state,next_state;
  reg[3:0]count;
  parameter IDLE=2'b00,TRANSMIT=2'b01,STOP=2'b10;
  always@(posedge clk or posedge rst)begin
    if(rst)
      state<=IDLE;
    else
      state<=next_state;
  end
  always@(*)begin 
  case(state)
    IDLE:
      next_state=en?TRANSMIT:IDLE;
    TRANSMIT:
      next_state=(count==7)?STOP:TRANSMIT;
    STOP:
    next_state=IDLE;
    default:
    next_state = IDLE;
  endcase
  end
 
   always@(posedge clk or posedge rst)begin
     if(rst)
       begin 
       cs<=1;
         mosi<=0;
         shift<=0;
         count<=0;
         sclk<=0;
       end
     else
       begin 
         case(state)
           IDLE:begin 
             cs<=1;
             count <= 0;
             sclk<=0;
       if(en)
        shift <= mdatain;
           end
           TRANSMIT:begin 
             cs<=0;
//              count<=1;
      
//              shift<=mdatain;
             sclk<=~sclk;
             
             if(sclk==0) 
            begin
              mosi<=shift[7];
              shift<={shift[6:0],miso};
              count<=count+1;
            end 
          end 
          STOP:begin
            cs<=1;
            sclk<=0;
            count<=0;
          end
         endcase
       end
   end
endmodule
