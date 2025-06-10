module ptmch_trg (
    // Reset/Clock
    input  logic RESET_N,
    input  logic CLK160M,
    input  logic SPI_CS,
    input  logic SPI_CLK,
    input  logic SPI_MOSI,
    output logic TRG_PLS
);

    // Parameters
    parameter logic [7:0] P_PROGRAM_EXECUTE = 8'h02;

    // Internal Registers
    logic [7:0]  reg_shift;
    logic [3:0]  reg_shift_cnt;
    logic [7:0]  reg_inst_chk_stage0;
    logic [7:0]  reg_inst_chk_stage1;
    logic [7:0]  reg_inst_chk_stage2;
    logic [7:0]  reg_inst_chk_stage3;
    logic        inst_match;
    logic        inst_match_dly1;
    logic        inst_match_dly2;
    logic [3:0]  pls_counter;

    logic        async_spi_cs_1d;
    logic        reg_spi_cs_2d;
    logic        cs_sync;
    logic        cs_sync_dly1;
    logic        cs_sync_dly2;

    // Match Logic
    assign inst_match = (reg_inst_chk_stage3 == P_PROGRAM_EXECUTE);
    assign inst_edge  = inst_match & ~inst_match_dly2;
    assign cs_falling_edge = cs_sync & ~cs_sync_dly2;

    // Shift Register (on SPI_CLK domain)
    always_ff @(posedge SPI_CLK) begin
        if (!RESET_N || cs_falling_edge)
            reg_shift <= 8'h00;
        else
            reg_shift <= {reg_shift[6:0], SPI_MOSI};
    end

    // Shift Counter (on SPI_CLK domain)
    always_ff @(posedge SPI_CLK) begin
        if (!RESET_N || cs_falling_edge)
            reg_shift_cnt <= 4'd0;
        else if (reg_shift_cnt != 4'd9)
            reg_shift_cnt <= reg_shift_cnt + 1;
    end

    // Instruction Check Pipeline (on CLK160M domain)
    always_ff @(posedge CLK160M) begin
        if (!RESET_N || cs_falling_edge) begin
            reg_inst_chk_stage0 <= 8'h00;
            reg_inst_chk_stage1 <= 8'h00;
            reg_inst_chk_stage2 <= 8'h00;
            reg_inst_chk_stage3 <= 8'h00;
        end else begin
            if (reg_shift_cnt == 4'd8)
                reg_inst_chk_stage0 <= reg_shift;
            reg_inst_chk_stage1 <= reg_inst_chk_stage0;
            reg_inst_chk_stage2 <= reg_inst_chk_stage1;
            reg_inst_chk_stage3 <= reg_inst_chk_stage2;
        end
    end

    // Match Pulse Pipeline (on CLK160M domain)
    always_ff @(posedge CLK160M) begin
        if (!RESET_N || cs_falling_edge) begin
            inst_match_dly1 <= 1'b0;
            inst_match_dly2 <= 1'b0;
        end else begin
            inst_match_dly1 <= inst_match;
            inst_match_dly2 <= inst_match_dly1;
        end
    end

    // Pulse Counter
    always_ff @(posedge CLK160M) begin
        if (!RESET_N || inst_edge)
            pls_counter <= 4'd0;
        else if (pls_counter != 4'd15)
            pls_counter <= pls_counter + 1;
    end

    // SPI_CS Synchronizer
    always_ff @(posedge CLK160M) begin
        if (!RESET_N) begin
            async_spi_cs_1d <= 1'b0;
            reg_spi_cs_2d   <= 1'b0;
            cs_sync         <= 1'b0;
            cs_sync_dly1    <= 1'b0;
            cs_sync_dly2    <= 1'b0;
        end else begin
            async_spi_cs_1d <= SPI_CS;
            reg_spi_cs_2d   <= async_spi_cs_1d;
            cs_sync         <= reg_spi_cs_2d;
            cs_sync_dly1    <= cs_sync;
            cs_sync_dly2    <= cs_sync_dly1;
        end
    end

    // Trigger Pulse Output
    assign TRG_PLS = (pls_counter < 4'd15);

endmodule
