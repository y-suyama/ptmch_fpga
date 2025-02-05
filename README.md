# ptmch_fpga use EK-10M08E144 only
NAND Flash Instaraction Detect & Trigger Pulse output

# Connection SPI Signal(MAX 100MHz)
PIN_60  SPI_CLK
PIN_59  SPI_CS
PIN_58  SPI_MOSI

# use oscilloscope trigger signal
PIN_57 TRG_PLS[0] Write Excute
PIN_56 TRG_PLS[1] Read Status
PIN_55 TRG_PLS[2] 128KB Block Erase
PIN_52 TRG_PLS[3] Page Data Read
PIN_50 TRG_PLS[4] Write Status

