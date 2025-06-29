module spi_wrapper (MOSI , MISO , SS_n , clk , rst_n);

input MOSI , SS_n , clk , rst_n ;
output MISO ;

wire[10:0] rx_data ;
wire rx_valid , tx_valid ;
wire [7:0] tx_data ;

spi_slave dut1 (MOSI , MISO , SS_n , clk , rst_n , rx_data , rx_valid , tx_data , tx_valid );

ram dut2(rx_data ,clk , rst_n , rx_valid , tx_data ,tx_valid);
endmodule
