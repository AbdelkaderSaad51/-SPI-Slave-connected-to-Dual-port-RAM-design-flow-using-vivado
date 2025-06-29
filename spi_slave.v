module spi_slave (MOSI , MISO , SS_n , clk , rst_n , rx_data , rx_valid , tx_data , tx_valid );
parameter [2:0]IDLE = 3'b000;
parameter [2:0]READ_DATA = 3'b001;
parameter [2:0]READ_ADD = 3'b010;
parameter [2:0]CHK_CMD = 3'b011;
parameter [2:0]WRITE = 3'b100;

input MOSI  , SS_n , tx_valid, clk , rst_n;
input [7:0] tx_data;
output reg [10:0] rx_data;
output reg rx_valid , MISO=0;
(* fsm_encoding = "sequential" *)
reg [2:0] ns ,cs;  
reg address_or_read=0;
reg control_bit ;
integer counter = 10;
integer counter_to_recieve = 7;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		cs <= IDLE ;
	end
	else  begin
		cs <= ns;
	end
end

//next stage
always @(cs or SS_n or control_bit ) begin
case (cs)
IDLE : begin
	if (SS_n == 0) 
	ns = CHK_CMD;
	else if (SS_n == 1)
	ns = IDLE;
end 

CHK_CMD : begin
	if (SS_n ==0 && control_bit==0 ) 
	ns = WRITE;	
	else if (SS_n ==0 && control_bit ==1 && address_or_read ==0)begin 
	ns = READ_ADD ;
	address_or_read =1;
	end
	else if (SS_n ==0 && control_bit ==1 && address_or_read ==1)begin
	ns = READ_DATA ;
	address_or_read =0;
	end
	else if (SS_n==1)
	ns = IDLE;    	
end


WRITE : begin
	if (SS_n == 0 )
	ns = WRITE;
	else if (SS_n == 1)
	ns = IDLE ;
	end

READ_ADD : begin
	if (SS_n ==0 )
	ns = READ_ADD;
	else if (SS_n==1)
	ns = IDLE ;	

end

READ_DATA : begin
	if (SS_n == 0)
	ns = READ_DATA;
	else if (SS_n==1)
	ns = IDLE; 
end
default : ns = IDLE;
endcase
end


//output logic
always @(posedge clk) begin

case (cs)
IDLE :begin
	rx_valid <=0;
	control_bit <= MOSI;//0
end

WRITE : begin
	rx_valid <=1;
	rx_data[10] <= control_bit ;
	rx_data [counter -1] <= MOSI;
	counter <= counter -1;
	if (counter == 0)
	counter <= 10; 
end

READ_ADD : begin
	rx_valid <= 1;
	rx_data [10] <= control_bit;
	rx_data [counter-1] <= MOSI;
	counter <= counter -1;
	if (counter==0)
	counter <= 10;
end

READ_DATA : begin
	rx_data [10] <= control_bit;
	rx_data [counter-1] <= MOSI;
	counter <= counter -1;

if (counter==0)
counter <=10;

if (tx_valid) begin
MISO <= tx_data[counter_to_recieve];
counter_to_recieve <= counter_to_recieve -1;
end

if (counter_to_recieve==0)
counter_to_recieve <= 7;

end
endcase
end
endmodule




