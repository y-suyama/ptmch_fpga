	component nios2_system is
		port (
			altpll_0_c1_clk : out std_logic;        -- clk
			clock_clk       : in  std_logic := 'X'; -- clk
			reset_n_reset_n : in  std_logic := 'X'  -- reset_n
		);
	end component nios2_system;

	u0 : component nios2_system
		port map (
			altpll_0_c1_clk => CONNECTED_TO_altpll_0_c1_clk, -- altpll_0_c1.clk
			clock_clk       => CONNECTED_TO_clock_clk,       --       clock.clk
			reset_n_reset_n => CONNECTED_TO_reset_n_reset_n  --     reset_n.reset_n
		);

