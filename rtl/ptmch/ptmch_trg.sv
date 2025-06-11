module ptmch_trg (
    // Reset/Clock
    input  logic RESET_N,
    input  logic CLK160M,
    input  logic SPI_CS,
    input  logic SPI_CLK,
    input  logic SPI_MOSI,
    output logic TRG_PLS
);

    // === Parameters ===
    localparam logic [7:0] P_PROGRAM_EXECUTE = 8'h02;
    localparam int SHIFT_WIDTH  = 8;
    localparam int COUNTER_MAX  = 15;

    // === SPI_CLK Domain Signals ===
    logic [7:0]  shift_data;
    logic [3:0]  shift_cnt;

    logic        spi_cs_1d_clk, spi_cs_2d_clk;
    logic        spi_cs_fall_clk;

    // === CLK160M Domain Signals ===
    logic [7:0]  inst_pipe0, inst_pipe1, inst_pipe2, inst_pipe3;
    logic        inst_match, inst_match_q1, inst_match_q2;
    logic        inst_edge;

    logic [3:0]  pulse_counter;
    logic        trg_pls_int;

    logic        spi_cs_1d_sys, spi_cs_2d_sys;
    logic        spi_cs_sync, spi_cs_q1, spi_cs_q2;
    logic        spi_cs_fall_sys;

    // === SPI_CS Falling Edge (per domain) ===
    // SPI_CLK domain
    always_ff @(posedge SPI_CLK or negedge RESET_N) begin
        if (!RESET_N) begin
            spi_cs_1d_clk <= 1'b1;
            spi_cs_2d_clk <= 1'b1;
        end else begin
            spi_cs_1d_clk <= SPI_CS;
            spi_cs_2d_clk <= spi_cs_1d_clk;
        end
    end
    assign spi_cs_fall_clk = spi_cs_2d_clk & ~spi_cs_1d_clk;

    // CLK160M domain
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if (!RESET_N) begin
            spi_cs_1d_sys <= 1'b1;
            spi_cs_2d_sys <= 1'b1;
            spi_cs_sync   <= 1'b1;
            spi_cs_q1     <= 1'b1;
            spi_cs_q2     <= 1'b1;
        end else begin
            spi_cs_1d_sys <= SPI_CS;
            spi_cs_2d_sys <= spi_cs_1d_sys;
            spi_cs_sync   <= spi_cs_2d_sys;
            spi_cs_q1     <= spi_cs_sync;
            spi_cs_q2     <= spi_cs_q1;
        end
    end
    assign spi_cs_fall_sys = spi_cs_q2 & ~spi_cs_q1;

    // === SPI Shift Register ===
    always_ff @(posedge SPI_CLK or negedge RESET_N) begin
        if (!RESET_N)
            shift_data <= 8'h00;
        else if (spi_cs_fall_clk)
            shift_data <= 8'h00;
        else
            shift_data <= {shift_data[6:0], SPI_MOSI};
    end

    // === Shift Bit Counter ===
    always_ff @(posedge SPI_CLK or negedge RESET_N) begin
        if (!RESET_N)
            shift_cnt <= 4'd0;
        else if (spi_cs_fall_clk)
            shift_cnt <= 4'd0;
        else if (shift_cnt != SHIFT_WIDTH + 1)
            shift_cnt <= shift_cnt + 1;
    end

    // === Instruction Pipe ===
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if (!RESET_N) begin
            inst_pipe0 <= 8'h00;
            inst_pipe1 <= 8'h00;
            inst_pipe2 <= 8'h00;
            inst_pipe3 <= 8'h00;
        end else begin
            if (spi_cs_fall_sys)
                inst_pipe0 <= 8'h00;
            else if (shift_cnt == SHIFT_WIDTH)
                inst_pipe0 <= shift_data;

            inst_pipe1 <= inst_pipe0;
            inst_pipe2 <= inst_pipe1;
            inst_pipe3 <= inst_pipe2;
        end
    end

    assign inst_match = (inst_pipe3 == P_PROGRAM_EXECUTE);

    // === Match Edge Detection ===
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if (!RESET_N) begin
            inst_match_q1 <= 1'b0;
            inst_match_q2 <= 1'b0;
        end else begin
            inst_match_q1 <= inst_match;
            inst_match_q2 <= inst_match_q1;
        end
    end
    assign inst_edge = inst_match & ~inst_match_q2;

    // === Trigger Pulse Counter ===
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if (!RESET_N)
            pulse_counter <= 4'd0;
        else if (inst_edge)
            pulse_counter <= 4'd0;
        else if (pulse_counter != COUNTER_MAX)
            pulse_counter <= pulse_counter + 1;
    end

    // === TRG_PLS FF Output ===
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if (!RESET_N)
            trg_pls_int <= 1'b0;
        else
            trg_pls_int <= (pulse_counter < COUNTER_MAX);
    end

    assign TRG_PLS = trg_pls_int;

endmodule
