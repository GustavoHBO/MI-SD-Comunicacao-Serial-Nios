module UART(button, clk, reset, rx, tx, led);
	
	input button;
	input clk;
	input reset;
	input rx;
	
	output tx;
	output [3:0] led;
	
	wire clk_speed;
	wire [7:0] data;
	wire ready;
	
	wire [1:0] speed_clk_divider;
	wire pulse_clk_divider;
	
	assign led = ~data[3:0];
	//assign tx = rx;
	
	clk_divider clk_divider (
		.clk_in(clk),
		.rst(~reset),
		.clk_out(clk_speed),
		.pulse(pulse_clk_divider),
		.speed(speed_clk_divider)
	);
	
	 control_uart control_uart(
	 	.clk(clk),
	 	.dataReady(),
	 	.rst(~reset),
	 	.dataIn(8'b00001100),
	 	//.dataOut()
	 );

	uart_rx uart_rx (
		.rx(rx),
		.rst(~reset),
		.clk(clk_speed),
		.data(data),
		.ready(ready)
		);
	
	uart_tx uart_tx(
		.data(data), 
		.reset(~reset), 
		.clk(clk_speed), 
		.ready(ready), 
		.tx(tx)
		);
	
endmodule