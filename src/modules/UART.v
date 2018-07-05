module UART(button, clk, reset, rx, tx, led, data_packet, rs, rw, en,dat,LCD_N,LCD_P);
	
	input button;
	input clk;
	input reset;
	input rx;
	
	output tx;
	output [3:0] led;
	output [31:0] data_packet;
	output [7:0] dat; 
	output  rs,rw,en,LCD_N,LCD_P; 
	
	wire [31:0] data_packet_wire;
	
	assign data_packet = data_packet_wire;
	assign dataIn = data_packet[31:24];
	wire clk_speed;
	wire [7:0] data;
	wire ready;
	wire [7:0] configuration;
	wire [7:0] dataIn;
	
	wire [1:0] speed_clk_divider;
	wire pulse_configuration;
	
	reg [1:0] modo;
	
	initial modo = 2'b00;
	
	assign led = ~data[3:0];
	//assign tx = rx;
	
	clk_divider clk_divider (
		.clk_in(clk),
		.rst(~reset),
		.clk_out(clk_speed),
		.pulse(pulse_configuration),
		.speed(configuration[7:6])
	);
	
	 control_uart control_uart(
	 	.clk(clk),
	 	.dataReady(),
	 	.rst(~reset),
	 	.dataIn(8'b00001100),
	 	.dataOut(configuration),
		.pulse(pulse_configuration),
		.dataReady(1'b0),
		.packet(data_packet_wire)
	 );

	uart_rx uart_rx (
		.rx(rx),
		.rst(~reset),
		.clk(clk_speed),
		.data(data),
		.ready(ready),
		.pulse(pulse_configuration),
		.configuration(configuration [7:6])
		);
	
	uart_tx uart_tx(
		.data(data), 
		.reset(~reset), 
		.clk(clk_speed), 
		.ready(ready), 
		.tx(tx),
		.configuration(configuration [7:6])
		);
		
	LCD1602 LCD1602(
		 .clk(clk),
		 .rs(rs),
		 .rw(rw), 
		 .en(en),
		 .dataIn(dataIn),
		 .dat(dat),
		 .LCD_N(LCD_N),
		 .LCD_P(LCD_P)
		 ); 
	
endmodule