onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_program_excute
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_readstatus1
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_readstatus2
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_128kb_blockerase
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_pagedata_read
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_writestatus1
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_writestatus2
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/RESET_N
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/CLK160M
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/SPI_CS
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/SPI_CLK
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/SPI_MOSI
add wave -noupdate -expand /ptmch_top_tb/_ptmch_top/trg_inst/TRG_PLS
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_inst_sht
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_inst_cnt
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/ar_inst_chk
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_inst_chk_1d
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_inst_chk_2d
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_inst_chk_3d
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/c_inst_mch
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/ar_inst_mch_sft1
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_inst_mch_sft2
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/c_inst_edge
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_pls_cnt
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/ar_spi_cs_1d
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_spi_cs_2d
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_cs_sync
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_cs_sync_sft1
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/sr_cs_sync_sft2
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/c_cs_edge
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/n_trg_pls
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 330
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {790528 ps}
