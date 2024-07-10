onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/p_program_excute
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/RESET_N
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/CLK200M
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/SPI_CS
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/SPI_CLK
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/SPI_MOSI
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/TRG_PLS
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
add wave -noupdate /ptmch_top_tb/_ptmch_top/trg_inst/c_cs_edge_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2220000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
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
configure wave -timelineunits ps
update
WaveRestoreZoom {1708302 ps} {2571698 ps}
