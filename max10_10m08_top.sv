//==================================================================================================
//  Company name        : 
//  Date                : 
//  File Name           : max10_10m08_top.v
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0
//
//==================================================================================================
// Import
//==================================================================================================
// None
//==================================================================================================
// Module
//==================================================================================================
module max10_10m08_top(
    // Clock, Reset
    input  logic        CLK50M,
    input  logic        RESET_N,
    // SPI Signal
    input  logic        SPI_CS,
    input  logic        SPI_CLK,
    input  logic        SPI_MOSI,
    output logic        TRG_PLS
   // Dip Switch Inputs
    // Dip Switch Inputs
//   input logic SWITCH1, 
//   input logic SWITCH2,
//   input logic SWITCH3,
//   input logic SWITCH4,
//   input logic SWITCH5,
//   // PTMATCH Interface
//   input  logic PTCLK,
//   input  logic PTDAT,
//   output logic PTPLS,
//   // Uart interface
//   input  logic RXD_IN,
//   output logic TXD_OUT,
//   // I2C Master
//   inout logic I2C_SCL,
//   inout logic I2C_SDA,
//   // LED Outputs
//   output logic[ 4:0] LED,
//   // Signal Tap
//   input logic SGTP_CLK,
//   input logic [ 3:0] SGTP_DAT,
//   //Arduino I/Os
//   inout logic Arduino_IO0, 
//   inout logic Arduino_IO1,
//   inout logic Arduino_IO2,
//   inout logic Arduino_IO3,
//   inout logic Arduino_IO4,
//   inout logic Arduino_IO5,
//   inout logic Arduino_IO6,
//   inout logic Arduino_IO7,
//   inout logic Arduino_IO8,
//   inout logic Arduino_IO9, 
//   inout logic Arduino_IO10,
//   inout logic Arduino_IO11,
//   inout logic Arduino_IO12,
//   inout logic Arduino_IO13,
//   //There are 40 GPIOs. In this example pins are not used as LVDS pins. 
//   //NOTE: Refer README.txt on how to use these GPIOs with LVDS option. 
//   inout logic DIFFIO_L27N_PLL_CLKOUTN, 
//   inout logic DIFFIO_L27P_PLL_CLKOUTP,
//   inout logic DIFFIO_L20P_CLK1P,
///    inout logic DIFFIO_R14P_CLK2P,
///    inout logic DIFFIO_R14N_CLK2N,
//   inout logic DIFFIO_R16P_CLK3P,
//   inout logic DIFFIO_R16N_CLK3N,
//   inout logic DIFFIO_B1N, 
//   inout logic DIFFIO_B1P,
//   inout logic DIFFIO_B3N,
//   inout logic DIFFIO_B3P,
//   inout logic DIFFIO_B5N,
//   inout logic DIFFIO_B5P,
//   inout logic DIFFIO_B9N,
//   inout logic DIFFIO_B9P,
//   inout logic DIFFIO_T1P,
//   inout logic DIFFIO_T1N,
//   inout logic DIFFIO_T4N,
//   inout logic DIFFIO_T6P,
//   inout logic DIFFIO_B12N,
//   inout logic DIFFIO_B12P,
//   inout logic DIFFIO_B14N,
///    inout logic DIFFIO_R18P,
///    inout logic DIFFIO_R18N,
///    inout logic DIFFIO_R27P,
//   inout logic DIFFIO_R28P,
//   inout logic DIFFIO_R27N,
//   inout logic DIFFIO_R28N,
//   inout logic DIFFIO_R33P,
//   inout logic DIFFIO_R33N,
//   inout logic DIFFIO_T10P,
//    inout logic DIFFIO_T10N 
);
//=================================================================
//  Internal Signal
//=================================================================
//    logic  w_scl_oe;
//    logic  w_sda_oe;
//    logic  w_i2c_scl;
//    logic  w_i2c_sda;
    logic  w_clk200m;
//=================================================================
//  output Port
//=================================================================
//    assign I2C_SCL = (w_scl_oe)? 1'b0 : 1'bz;
//    assign I2C_SDA = (w_sda_oe)? 1'b0 : 1'bz;
//    assign w_i2c_scl = I2C_SCL;
//    assign w_i2c_sda = I2C_SDA;
//==================================================================================================
//  Structural coding
//==================================================================================================

nios2_system u0(
    .clock_clk                    (CLK50M),
    .reset_n_reset_n              (RESET_N),
    .uart_external_connection_rxd (RXD_IN),
    .uart_external_connection_txd (TXD_OUT),
    .altpll_0_c1_clk              (w_clk200m)
   );

ptmch_top ptmch_inst(
    // Reset/Clock
    .RESET_N(RESET_N),
    .CLK200M(w_clk200m),
    // SPI Interface
    .SPI_CS(SPI_CS),
    .SPI_CLK(SPI_CLK),
    .SPI_MOSI(SPI_MOSI),
    .TRG_PLS(TRG_PLS)
);

endmodule
