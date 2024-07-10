	nios2_system u0 (
		.clock_clk                    (<connected-to-clock_clk>),                    //                    clock.clk
		.reset_n_reset_n              (<connected-to-reset_n_reset_n>),              //                  reset_n.reset_n
		.uart_external_connection_rxd (<connected-to-uart_external_connection_rxd>), // uart_external_connection.rxd
		.uart_external_connection_txd (<connected-to-uart_external_connection_txd>), //                         .txd
		.altpll_0_c1_clk              (<connected-to-altpll_0_c1_clk>)               //              altpll_0_c1.clk
	);

