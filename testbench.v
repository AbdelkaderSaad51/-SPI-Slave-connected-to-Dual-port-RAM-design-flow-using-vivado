module SPI_Wrapper_tb();
reg MOSI, SS_n, clk, rst_n;
wire MISO;
reg [9:0] write_addr = 10'b00_1111_0000;//address 240 in decimal

reg [9:0] write_data = 10'b01_1010_1110; // this data will write in the previos address

reg [9:0] read_addr = 10'b10_1111_0000; // address 240

reg [9:0] read_data = 10'b11_0000_0000;// it will be dummy data but we want only 11 to make ram to know that it in read state 
integer i = 0;
spi_wrapper DUT(MOSI, MISO, SS_n, clk, rst_n);

initial begin
	clk =0;
	forever
	#10 clk = ~clk;
end

initial begin
	$readmemh ("mem.dat" , DUT.dut2.mem);
	rst_n = 0;
	SS_n = 1;
	#50;
	rst_n = 1;
	MOSI = 0;
	SS_n = 0;
	#50
	for (i=0; i<10 ; i=i+1)begin
		@(negedge clk)
		MOSI = write_addr [9-i];
		#5;
	end
	SS_n = 1;
	#50


	// to write data in the previos address
	MOSI = 0;
	SS_n = 0;
	#50
	for (i=0 ; i<10 ; i=i+1)begin
		@(negedge clk)
		MOSI = write_data [9-i];
		#5;
	end
	SS_n = 1;
	#50
	// to write the address that i will read from
	MOSI =1;
	SS_n =0;
	#50
	for (i=0 ; i<10 ; i=i+1)begin
		@(negedge clk)
		MOSI = read_addr [9-i];
		#5;
	end
	SS_n =1;
	#50
	MOSI =1;
	SS_n =0;
	#50
	for (i=0 ; i<10 ; i=i+1)begin
		@(negedge clk)
		MOSI = read_data [9-i];
		#5;	
	end
	
	#40 $stop;
end

endmodule