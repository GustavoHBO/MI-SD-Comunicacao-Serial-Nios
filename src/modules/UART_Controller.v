module UART_Controller(button, clk, rst, rx, led, tx);
	
	input button;
	input clk;
	input rst;
	input rx;
	
	output [3:0] led;
	output tx;
	
	wire clk_9600;
	wire [7:0] data;
	wire ready;
	
	
	assign led = ~data[3:0];
	//assign tx = rx;
	
	clk_divider clk_divider (
		.clk_in(clk),
		.rst(~rst),
		.clk_out(clk_9600)
	);
	
	uart_rx uart_rx (
		.rx(rx),
		.rst(~rst),
		.clk(clk_9600),
		.data(data),
		.ready(ready)
		);
	
	uart_tx uart_tx(
		.data(data),
		.rst(~rst), 
		.clk(clk_9600), 
		.ready(ready), 
		.tx(tx)
	);
	
endmodule