//master
module apb_master(input pclk,rst,transfer,pready,input[15:0]addr,wdata,output reg [15:0]paddar,pwdata,output reg psel,penable);
  reg [1:0] ns,cs;
  parameter idle=2'b00,setup=2'b01,access=2'b10;
  always @(posedge pclk or posedge rst)begin 
    
    if (rst)
      cs<=idle;
    else
      cs<=ns;
  end
  always@(*)begin 
    ns=cs;
    if (cs==idle)begin
      if(transfer)
        ns=setup;
       else 
        ns=idle;
  end
    else if (cs==setup)begin
      ns=access;
    end
    else if (cs==access) begin
      if(pready&&transfer)
        ns=setup;
      else if(pready)
        ns=idle;
      else
        ns=access;
      
    end
    
  end
  always @(posedge pclk or posedge rst) begin 
    if(rst)begin 
    paddar<=16'b0;
    pwdata<=16'b0;
    psel<=1'b0;
    penable<=1'b0;
    end  
    else begin
      if (cs==idle)begin 
        psel<=1'b0;
        penable<=1'b0;
      end 
      else if (cs==setup ) begin
        psel<=1'b1;
        penable<=1'b0;
        paddar<=addr;
        pwdata<=wdata;
      end
      else if(cs==access) begin
        psel<=1'b1;
        penable<=1'b1;
      end
    end
  end
endmodule
//slave

module apb_slave (input pclk,rst,psel,pwrite,penable,input [15:0]padd,pwdata,output reg pready,output  [15:0]prdata);
  reg [15:0] mem [31:0];
 reg [15:0]add;
  // assign prdata=mem[padd[15:0]];
  always @(posedge pclk or posedge rst )begin
  if (rst)
    pready<=0;
    else if (psel&&penable&&!pwrite) begin
      pready<=1;
    add<=padd[15:0];
  end
    else if(psel&&penable&&pwrite) begin
      pready <=1;
      mem[padd[4:0]]<=pwdata;
  end
  else
 pready <=0;
  end
endmodule
//topmodule


module  apb_top(input pclk,rst,transfer,pwrite,input [15:0]wdata,addr,output psel,penable,output[15:0]paddar,pwdata); wire pready;
wire [15:0] prdata;
apb_master 
d0(.pclk(pclk),.rst(rst),.transfer(transfer),.pready(pready),.addr(addr),.wdata(wdata),.paddar(paddar),
   .pwdata(pwdata),.psel(psel),.penable(penable));
apb_slave d1(.pclk(pclk),.rst(rst),.psel(psel),.pwrite(pwrite),.penable(penable),.padd(paddar),.pwdata(pwdata),
.pready(pready),.prdata(prdata));
endmodule
