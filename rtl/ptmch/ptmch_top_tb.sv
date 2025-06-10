//==================================================================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_top_tb.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0
//
//==================================================================================================
// time scale
//==================================================================================================
    `timescale 1ns/1ps
//==================================================================================================
// Module
//==================================================================================================
module ptmch_top_tb();
    // Reset/Clock
    logic        RESET_N;
    logic        CLK75M;
    // SPI Interface
    logic        SPI_CS;
    logic        SPI_CLK;
    logic        SPI_MOSI;
    logic        TRG_PLS;
//==================================================================================================
//  Structural coding
//==================================================================================================
ptmch_top _ptmch_top(
    .RESET_N(RESET_N),
    .CLK75M(CLK75M),
    .SPI_CS(SPI_CS),
    .SPI_CLK(SPI_CLK),
    .SPI_MOSI(SPI_MOSI),
    .TRG_PLS(TRG_PLS)
);
//==================================================================================================
//  PARAMETER declarations
//==================================================================================================
    parameter cycle_75m         = 13.3;
    parameter half_cycle_75m    = 6.65;
    parameter cycle_spi          = 20;
    parameter half_cycle_spi     = 10;
    parameter start_delay        = 100;
    parameter cs_delay           = 200;
    parameter clk_delay          = 300;
//==================================================================================================
//  RESET/Clock
//==================================================================================================
    // PLL Clock 75MHz
    always #half_cycle_75m CLK75M = ~CLK75M;
//==================================================================================================
//  Initial
//==================================================================================================
    initial begin

        RESET_N  = 1'b1;
        CLK75M  = 1'b1;
        SPI_CS   = 1'b1;
        SPI_CLK  = 1'b0;
        SPI_MOSI = 1'b1;
        #start_delay    RESET_N = 1'b0;
        #start_delay    RESET_N = 1'b1;
        // 1 time
        #cs_delay       SPI_CS = 1'b0;
        #clk_delay      SPI_MOSI = 1'b0;//[7]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[6]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[5]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b1;//[4]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[3]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[2]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[1]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[0]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_CS = 1'b1;
        // 2 time
        #cs_delay       SPI_CS = 1'b0;
        #clk_delay      SPI_MOSI = 1'b0;//[7]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b1;//[6]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[5]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b1;//[4]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[3]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[2]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[1]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[0]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_CS = 1'b1;
        // 3 time
        #cs_delay       SPI_CS = 1'b0;
        #clk_delay      SPI_MOSI = 1'b0;//[7]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[6]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[5]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b1;//[4]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[3]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[2]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[1]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_MOSI = 1'b0;//[0]
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
        #half_cycle_spi SPI_CLK = 1'b1;
        #half_cycle_spi SPI_CLK = 1'b0;
                        SPI_CS = 1'b1;
//        $finish;
   end
endmodule
