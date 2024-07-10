
module nios2_system (
	clock_clk,
	reset_n_reset_n,
	uart_external_connection_rxd,
	uart_external_connection_txd,
	altpll_0_c1_clk);	

	input		clock_clk;
	input		reset_n_reset_n;
	input		uart_external_connection_rxd;
	output		uart_external_connection_txd;
	output		altpll_0_c1_clk;
endmodule
