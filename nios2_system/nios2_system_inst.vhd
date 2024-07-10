	component nios2_system is
		port (
			clock_clk                    : in  std_logic := 'X'; -- clk
			reset_n_reset_n              : in  std_logic := 'X'; -- reset_n
			uart_external_connection_rxd : in  std_logic := 'X'; -- rxd
			uart_external_connection_txd : out std_logic;        -- txd
			altpll_0_c1_clk              : out std_logic         -- clk
		);
	end component nios2_system;

	u0 : component nios2_system
		port map (
			clock_clk                    => CONNECTED_TO_clock_clk,                    --                    clock.clk
			reset_n_reset_n              => CONNECTED_TO_reset_n_reset_n,              --                  reset_n.reset_n
			uart_external_connection_rxd => CONNECTED_TO_uart_external_connection_rxd, -- uart_external_connection.rxd
			uart_external_connection_txd => CONNECTED_TO_uart_external_connection_txd, --                         .txd
			altpll_0_c1_clk              => CONNECTED_TO_altpll_0_c1_clk               --              altpll_0_c1.clk
		);

