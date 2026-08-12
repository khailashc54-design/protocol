`timescale 1ns/1ps

module spi_tb;

    reg clk;
    reg rst;
    reg start;

    reg [7:0] ma_datain;
    reg [7:0] sa_datain;

    wire [7:0] ma_dataout;
    wire [7:0] sa_dataout;

    spi_top dut(
        .ma_datain(ma_datain),
        .sa_datain(sa_datain),
        .clk(clk),
        .start(start),
        .rst(rst),
        .ma_dataout(ma_dataout),
        .sa_dataout(sa_dataout)
    );

    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        rst = 1;
        start = 0;

        ma_datain = 8'b10101010;
        sa_datain = 8'b11001100;

        $display("START SPI TEST");

        #20 rst = 0;

        #20 start = 1;
        #10 start = 0;

        #500;

        $display("MASTER OUT = %b", ma_dataout);
        $display("SLAVE OUT  = %b", sa_dataout);

        $finish;
    end

endmodule
