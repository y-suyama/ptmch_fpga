`timescale 1ns/1ps

module ptmch_top_tb;

  // 信号宣言
  logic         RESET_N;
  logic         CLK160M;
  logic         SPI_CS;
  logic         SPI_CLK;
  logic         SPI_MOSI;
  logic  [4:0]  TRG_PLS;

  // 160MHz CLK生成（半周期 3.125ns）
  initial begin
    CLK160M = 0;
    forever #3.125 CLK160M = ~CLK160M;
  end

  // SPI_CLKはトランザクション内で生成するため、初期値は0に固定
  // 初期値設定＆ダンプファイル出力（必要に応じて）
  initial begin
    SPI_CS   = 1;    // 初期は非アクティブ
    SPI_CLK  = 0;
    SPI_MOSI = 1;    // 初期は 'H'
    $dumpfile("ptmch_top_tb.vcd");
    $dumpvars(0, ptmch_top_tb);
  end

  // DUT のインスタンス化
  ptmch_top dut_inst (
    .RESET_N(RESET_N),
    .CLK160M(CLK160M),
    .SPI_CS(SPI_CS),
    .SPI_CLK(SPI_CLK),
    .SPI_MOSI(SPI_MOSI),
    .TRG_PLS(TRG_PLS)
  );

  // リセット生成：開始から5msは low、その後 high に設定
  initial begin
    RESET_N = 0;
    // 5ms = 5,000,000 ns (1nsタイムスケールの場合)
    #5000000;
    RESET_N = 1;
  end

  // SPIトランザクション・タスク
  // ReadStatusトランザクションとして、最初に
  // 8ビットの命令、次に8ビットのアドレス、そして8クロック分は high-Z にする
  task spi_transaction(input [7:0] inst, input [7:0] addr);
    integer i;
    integer delay_high;
    begin
      $display("=== Starting transaction: Inst = 0x%0h, Addr = 0x%0h at time %0t ===", inst, addr, $time);

      // ※ SPI_CS が既に H の状態である前提
      // ① CS を L にしてトランザクション開始
      SPI_CS = 0;
      // ② CSがLになってから20ns後にSPI_CLKを開始
      #20;
      
      // ③ 命令バイト(8ビット)の送信（MSB から）
      for (i = 7; i >= 0; i--) begin
        // SPI_MOSI は、SPI_CLK の立ち上がりと同時に変化する
        SPI_MOSI = inst[i];
        #5;             // 少し待ってから
        SPI_CLK = 1;    // 上昇エッジでデータキャプチャ
        #5;             // クロックのハイ期間（計10ns周期）
        SPI_CLK = 0;
      end
      
      // ④ アドレスバイト(8ビット)の送信（MSB から）
      for (i = 7; i >= 0; i--) begin
        SPI_MOSI = addr[i];
        #5;
        SPI_CLK = 1;
        #5;
        SPI_CLK = 0;
      end
      
      // ⑤ Read Data 部分： 8クロック分、SPI_MOSI を High-Z にする
      SPI_MOSI = 1'bz;
      for (i = 0; i < 8; i++) begin
        #5;
        SPI_CLK = 1;
        #5;
        SPI_CLK = 0;
      end

      // ⑥ 最後のSPI_CLKから20ns後にCSをHへ戻す
      #20;
      SPI_CS  = 1;
      SPI_CLK = 0;  // CSがHの間はSPI_CLKはL
      // ⑦ CS非アクティブ期間は 50ns～200ns のランダム時間
      delay_high = $urandom_range(50,200);
      #delay_high;
      $display("=== Transaction complete at time %0t ===", $time);
    end
  endtask

  // メインテストシーケンス（各トランザクションを順次実施）
  initial begin
    // リセット解除後、システムが安定するまで少し待つ
    @(posedge RESET_N);
    #100;
    
    // 指定の ReadStatus シナリオを実施
    spi_transaction(8'h0F, 8'hA0);
    spi_transaction(8'h0F, 8'hB0);
    spi_transaction(8'h0F, 8'hC0);
    spi_transaction(8'h05, 8'hA0);
    spi_transaction(8'h05, 8'hB0);
    spi_transaction(8'h05, 8'hC0);
    
    // シミュレーション終了まで少し待つ
    #1000;
    $finish;
  end

endmodule