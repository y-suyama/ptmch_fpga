//=================================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_trg.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0
//
//=================================================================
// Import
//=================================================================
// None
//=================================================================
// Module
//=================================================================
module ptmch_trg(
    // Reset/Clock
    input  logic          RESET_N,
    input  logic          CLK160M,
    // Logic Interface
    input  logic          SPI_CS,
    input  logic          SPI_CLK,
    input  logic          SPI_MOSI,
    output logic [ 1: 0]  TRG_PLS
);
//=================================================================
//  PARAMETER declarations
//=================================================================
    parameter p_pageprogram   = 8'h02;
    parameter p_writeenable   = 8'h06;
//=================================================================
//  Internal Signal
//=================================================================
    logic [ 7: 0]  sr_inst_sht;
    logic [ 3: 0]  sr_inst_cnt;
    logic [ 3: 0]  ar_inst_cnt_1d;
    logic [ 3: 0]  sr_inst_cnt_2d;
    logic [ 3: 0]  sr_inst_cnt_3d;
    logic [ 3: 0]  sr_inst_cnt_4d;
    logic [ 7: 0]  ar_inst_chk;
    logic [ 7: 0]  sr_inst_chk_1d;
    logic [ 7: 0]  sr_inst_chk_2d;
    logic [ 7: 0]  sr_inst_chk_3d;
    logic          c_inst_mch;
    logic          ar_inst_mch_sft1;
    logic          sr_inst_mch_sft2;
    logic          c_inst_edge;
    logic [ 3: 0]  sr_pls_cnt;
    logic          ar_spi_cs_1d;
    logic          sr_spi_cs_2d;
    logic          sr_cs_sync;
    logic          sr_cs_sync_sft1;
    logic          sr_cs_sync_sft2;
    logic          c_cs_edge;
    logic          n_trg_pls;
    logic          c_spi_reset_n;
//=================================================================
//  output Port
//=================================================================
    // TRG_PLS Output sel
    assign   TRG_PLS[0]  = (sr_inst_chk_3d == p_pageprogram )? n_trg_pls:
                                                                   1'b0;
    assign   TRG_PLS[1]  = (sr_inst_chk_3d == p_writeenable)?  n_trg_pls:
                                                                   1'b0;
    assign   c_inst_edge = (c_inst_mch & ~sr_inst_mch_sft2);
    assign   c_cs_edge = (~sr_cs_sync & sr_cs_sync_sft2);
    assign   c_spi_reset_n = (~c_cs_edge & RESET_N);
//=================================================================
//  Structural coding
//=================================================================
    // CS Shift Register
    always_ff @(posedge SPI_CLK or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_sht  <= 8'h0;
        else if(sr_inst_cnt == 4'h8)
            sr_inst_sht <= sr_inst_sht;
        else
            sr_inst_sht[7:0]  <= {sr_inst_sht[6:0],SPI_MOSI};
    end
    //  Instraction COUNTER
    always_ff @(posedge SPI_CLK or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_cnt  <= 4'h0;
        else
            if(sr_inst_cnt == 4'h8 )// STOP
                sr_inst_cnt  <= sr_inst_cnt;
            else  // Count
                sr_inst_cnt <= sr_inst_cnt + 1'b1;
      end
    //  Instraction COUNTER 1Delay
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            ar_inst_cnt_1d  <= 4'h0;
        else
            ar_inst_cnt_1d <= sr_inst_cnt;
      end

    //  Instraction COUNTER 2Delay
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_cnt_2d  <= 4'h0;
        else
            sr_inst_cnt_2d <= ar_inst_cnt_1d;
      end

    //  Instraction COUNTER 1Delay
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_cnt_3d  <= 4'h0;
        else
            sr_inst_cnt_3d <= sr_inst_cnt_2d;
      end

    //  Instraction COUNTER 1Delay
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_cnt_4d  <= 4'h0;
        else if(sr_inst_cnt_2d == sr_inst_cnt_3d)
            sr_inst_cnt_4d <= sr_inst_cnt_3d;
        else
            sr_inst_cnt_4d <= sr_inst_cnt_4d;
      end

    // Instraction chk(async)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            ar_inst_chk  <= 8'h0;
        else
            if(sr_inst_cnt == 4'b1000 ) // Load          
                ar_inst_chk  <= sr_inst_sht;
            else
                ar_inst_chk  <= ar_inst_chk;
    end
    // Instraction chk(1d)
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_chk_1d  <= 8'h0;
        else
            sr_inst_chk_1d  <= ar_inst_chk;
    end
    // Instraction chk(2d)
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_chk_2d  <= 8'h0;
        else
            sr_inst_chk_2d  <= sr_inst_chk_1d;
    end
    // Instraction chk(3d)
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_chk_3d  <= 8'h0;
        else if(sr_inst_chk_1d == sr_inst_chk_2d)
            sr_inst_chk_3d  <= sr_inst_chk_2d;
        else
            sr_inst_chk_3d  <= sr_inst_chk_3d;
    end
    // Instracton Match pls(async)
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            ar_inst_mch_sft1  <= 1'b0;
        else
            ar_inst_mch_sft1  <= c_inst_mch;
    end
    // Instracton Match pls(sync)
    always_ff @(posedge CLK160M or negedge c_spi_reset_n) begin
        if(!c_spi_reset_n)
            sr_inst_mch_sft2  <= 1'b0;
        else
            sr_inst_mch_sft2  <= ar_inst_mch_sft1;
    end
    //  TRG PLS COUNTER
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_pls_cnt  <= 4'b1111;
        else
            if (c_inst_edge == 1'b1) // CLR
                sr_pls_cnt  <= 4'b0;
            else if(sr_pls_cnt == 4'b1111 )// STOP
                sr_pls_cnt  <= sr_pls_cnt;
            else  // Count
                sr_pls_cnt <= sr_pls_cnt + 1'b1;
      end
    // SPI CS(async 1d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            ar_spi_cs_1d  <= 1'h0;
        else
            ar_spi_cs_1d  <= SPI_CS;
    end
    // SPI CS(sync 2d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_spi_cs_2d  <= 1'h0;
        else
            sr_spi_cs_2d  <= ar_spi_cs_1d;
    end
    // SPI CS(sync 3d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_cs_sync  <= 1'h0;
        else
            sr_cs_sync  <= sr_spi_cs_2d;
    end
    // SPI CS(sft 1d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_cs_sync_sft1  <= 1'h0;
        else
            sr_cs_sync_sft1  <= sr_cs_sync;
    end
    // SPI CS(sft 2d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_cs_sync_sft2  <= 1'h0;
        else
            sr_cs_sync_sft2  <= sr_cs_sync_sft1;
    end

    // pattern match check
    always @* begin
        case (sr_inst_chk_3d)
            p_pageprogram   : c_inst_mch = 1'b1;
            p_writeenable   : c_inst_mch = 1'b1;
            default         : c_inst_mch = 1'b0;
        endcase
    end
 
    // TRG PLS time expander
    always @* begin
        case (sr_pls_cnt)
            4'b0000 : n_trg_pls = 1'b1;
            4'b0001 : n_trg_pls = 1'b1;
            4'b0010 : n_trg_pls = 1'b1;
            4'b0011 : n_trg_pls = 1'b1;
            4'b0100 : n_trg_pls = 1'b1;
            4'b0101 : n_trg_pls = 1'b1;
            4'b0110 : n_trg_pls = 1'b1;
            4'b0111 : n_trg_pls = 1'b1;
            4'b1000 : n_trg_pls = 1'b1;
            4'b1001 : n_trg_pls = 1'b1;
            4'b1010 : n_trg_pls = 1'b1;
            4'b1011 : n_trg_pls = 1'b1;
            4'b1100 : n_trg_pls = 1'b1;
            4'b1101 : n_trg_pls = 1'b1;
            4'b1110 : n_trg_pls = 1'b1;
            4'b1111 : n_trg_pls = 1'b0;
            default : n_trg_pls = 1'b0;
        endcase
    end
endmodule
