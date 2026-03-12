//master
module apb_master(input pclk,rst,transfer,pready,pwrite,input[3:0]addr,wdata,input[15:0]prdata,output reg [3:0]paddar,pwdata,output reg pwrite1, psel,penable,output reg [15:0]prout);
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
     pwrite1<=0;
      prout<=0;
    end  
    else begin
      if (cs==idle)begin 
        psel<=1'b0;
        penable<=1'b0;
      end 
      else if (cs==setup ) begin
        psel<=1'b1;
        penable<=1'b0;
//         paddar<=addr;
        if( pwrite) begin
        pwdata<=wdata;
        paddar<=addr;
        end
        else
          paddar<=addr;
        pwrite1<=pwrite;
      end
      else if(cs==access) begin
        psel<=1'b1;
        penable<=1'b1;
//         pready<=1;
        if(!pwrite && pready)
          prout<=prdata;
      end
    end
  end
endmodule
//slave1

module apb_slave1 (input pclk,rst,psel1,pwrite,penable,input [3:0]paddr,pwdata,output reg pready1,output [15:0]prdata1);
  reg [15:0] mem [15:0];
 //reg [15:0]add;
 // assign prdata=mem[paddr[15:0]];
  integer i;
initial begin            // memory initialization
 for(i=0;i<32;i=i+1)
 mem[i] = 0;
end
  always @(posedge pclk or posedge rst )begin
    if (rst) begin
    pready1=1;
   // prdata1<=0;
    end else if (psel1&&penable&&!pwrite) begin
      $display("read");
      pready1=1;
     // prdata1<=mem[paddr[4:0]];

  end
    else if (psel1 && penable&& pwrite) begin
     $display("write");
      pready1=1;
     mem[paddr]<=pwdata;
  end
end
  assign  prdata1=mem[paddr];
  endmodule
//slave2
module apb_slave2 (input pclk,rst,psel2,pwrite,penable,input [15:0]paddr,pwdata,output reg pready2,output [15:0]prdata2);
  reg [15:0] mem [15:0];
 //reg [15:0]add;
 // assign prdata=mem[paddr[15:0]];
  integer i;
initial begin            // memory initialization
 for(i=0;i<32;i=i+1)
 mem[i] = 0;
end
  always @(posedge pclk or posedge rst )begin
    if (rst) begin
    pready2<=0;
    end else if (psel2&&penable&&!pwrite) begin
      $display("read");
      pready2<=1;

  end
    else if (psel2&&penable&&pwrite) begin
     $display("write");
      pready2<=1;
     mem[paddr[15:0]]<=pwdata;
  end
end
  assign  prdata2=mem[paddr[15:0]];

  endmodule
module apb_slave3 (input pclk,rst,psel3,pwrite,penable,input [15:0]paddr,pwdata,output reg pready3,output [15:0]prdata3);
  reg [15:0] mem [15:0];
  integer i;
initial begin            // memory initialization
 for(i=0;i<32;i=i+1)
 mem[i] = 0;
end
  always @(posedge pclk or posedge rst )begin
    if (rst) begin
    pready3<=0;
    end else if (psel3&&penable&&!pwrite) begin
      $display("read");
      pready3<=1;

  end
    else if (psel3&&penable&&pwrite) begin
     $display("write");
      pready3<=1;
     mem[paddr[15:0]]<=pwdata;
  end
end
  assign  prdata3=mem[paddr];

  endmodule
module apb_slave4 (input pclk,rst,psel4,pwrite,penable,input [15:0]paddr,pwdata,output reg pready4,output [15:0]prdata4);
  reg [15:0] mem [15:0];
  integer i;
initial begin            // memory initialization
 for(i=0;i<32;i=i+1)
 mem[i] = 0;
end
  always @(posedge pclk or posedge rst )begin
    if (rst) begin
    pready4<=0;
    end else if (psel4&&penable&&!pwrite) begin
      $display("read");
      pready4<=1;
     

  end
    else if (psel4&&penable&&pwrite) begin
     $display("write");
      pready4<=1;
     mem[paddr[15:0]]<=pwdata;
  end
end
  assign  prdata4=mem[paddr];

  endmodule
//slave slelect
module decoder(input [1:0]daddr,output reg d0,d1,d2,d3);
  always@(*) begin 
    d0=0;d1=0;d2=0;d3=0;
    case(daddr[1:0])
      2'b00:d0=1;
      2'b01:d1=1;
      2'b10:d2=1;
      2'b11:d3=1;
       default:d0=0;
    endcase
 
  end
endmodule
//topmodule
module apb_top(input pclk,rst,transfer,pwrite,input [15:0]wdata,addr,input[15:0]prdata,output psel,penable,input [1:0]daddr,output[15:0]prout );wire [15:0]paddar;wire [15:0]pwdata;
wire pready;wire s0,s1,s2,s3; wire pwrite1;
wire [15:0] prdata1,prdata2,prdata3,prdata4;
wire pready1,pready2,pready3,pready4;
wire psel1,psel2,psel3,psel4;
  wire [15:0] prdat;
apb_master 
d0(.pclk(pclk),.rst(rst),.transfer(transfer),.pready(pready),.addr(addr),.wdata(wdata),.paddar(paddar),.pwdata(pwdata),.psel(psel),.penable(penable),.pwrite(pwrite),.pwrite1(pwrite1),.prout(prout),.prdata(prdata1));
   apb_slave1 d1(.pclk(pclk),.rst(rst),.psel1(psel1),.pwrite(pwrite1),.penable(penable),
                 .paddr(paddar),.pwdata(pwdata),.pready1(pready1),.prdata1(prdata1));
  apb_slave2 d2(.pclk(pclk),.rst(rst),.psel2(psel2),.pwrite(pwrite),.penable(penable),
                .paddr(paddar),.pwdata(pwdata),.pready2(pready2),.prdata2(prdata2));
  apb_slave3 d3(.pclk(pclk),.rst(rst),.psel3(psel3),.pwrite(pwrite),.penable(penable),.paddr(paddar),.pwdata(pwdata),.pready3(pready3),.prdata3(prdata3));
apb_slave4 d4(.pclk(pclk),.rst(rst),.psel4(psel4),.pwrite(pwrite),.penable(penable),.paddr(paddar),.pwdata(pwdata), .pready4(pready4),.prdata4(prdata4));
  decoder c1(.daddr(daddr),.d0(s0),.d1(s1),.d2(s2),.d3(s3));
  
 assign psel1 = s0;
 assign psel2 = s1;
 assign psel3 = s2;
 assign psel4 = s3;
 assign pready =s0?pready1:s1?pready2:s2?pready3:pready4;
 assign prdat =s0 ? prdata1 :s1 ? prdata2 :s2 ? prdata3 :prdata4;
  
endmodule


  //`include "apb_top.v"

module apb_top_tb;

reg pclk;
reg rst;
reg transfer;
reg pwrite;
//reg pready;

reg [15:0] addr;
reg [15:0] wdata;

wire psel;
wire penable;
  reg [15:0] daddr;
wire [15:0] pwdata;
  wire [15:0] prout;
  wire [15:0] prdata;
  

  apb_top dut( .*);
  /*.pclk(pclk),
  .rst(rst),
  .transfer(transfer),
  .pwrite(pwrite),
  .addr(addr),
  .wdata(wdata),
  .psel(psel),
  .penable(penable),
  .paddar(paddar),
  .pwdata(pwdata)
);*/

initial pclk = 0;
always #5 pclk = ~pclk;

initial
begin
  $dumpfile("out_apb.vcd");
  $dumpvars(0,apb_top_tb);

  $monitor("t=%0t rst=%b transfer=%b psel=%b pwrite=%b penable=%b addr=%b data=%b,psel3=%b,prout=%b",
           $time,rst,transfer,psel,pwrite,penable,addr,wdata,dut.psel3,prout);

  rst = 1;
  transfer = 0;
  pwrite = 0;
  addr = 0;
  wdata = 0;
  daddr=0;
  
 
  

  #10 rst = 0;

  #10 transfer = 1;
      pwrite = 1;
      addr=16'h0001;
  daddr[1:0] = 2'b00;
      wdata = 16'hAAAA;
  @(posedge pclk);
  @(posedge pclk);
//    transfer=0;
       
  #20 transfer = 1;
      pwrite = 0;
      addr=16'h0001;
  daddr[1:0] = 2'b00;
     // wdata = 16'hAAAA;
//   #10 transfer =1;
  
//   #20 transfer=0;
  
@(posedge pclk);
  @(posedge pclk);
   #10 $finish;

end

endmodule
