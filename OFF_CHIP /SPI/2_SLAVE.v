module slave(input sclk,rst,mosi,ss,output reg miso,output reg[7:0]data_out);
reg[7:0]shift_reg;
reg[3:0]count;
reg [1:0]state,nxt_state;
parameter IDLE=2'b00,SHIFT=2'b01,STOP=2'b10;
always@(posedge sclk or posedge rst)begin
    if(rst)
        state<=IDLE;
    else 
        state<=nxt_state;
end
always@(*)begin 
      case(state)
             IDLE:begin
                if(ss==0)
                  nxt_state=SHIFT;
                else
                  nxt_state=IDLE;
              end
              SHIFT:begin
                if(count==8)
                  nxt_state=STOP;
                else 
                  nxt_state=SHIFT;
              end 
              STOP:begin
                nxt_state=IDLE;
              end 

              default:nxt_state=IDLE;

      endcase
end 
always@(posedge sclk or posedge rst)begin
      if(rst)begin 
                miso<=0;
                data_out<=0;
                count<=0;
                shift_reg<=0;
      end 
        else begin 
           case(state)
                  IDLE:begin
                    miso<=0;
                    data_out<=0;
                    count<=0;
                  end 
                  SHIFT:begin
                    if(ss==0)begin
                        miso<=shift_reg[7];
                        shift_reg<={shift_reg[6:0],mosi};
                        count<=count+1;
                    end
                  end 
                  STOP:begin
                    if(ss==0 && count==8)begin
                        data_out<=shift_reg;
                        count<=0;
                    end
                  end
            endcase
         end 
    end 
endmodule
     
    
      
