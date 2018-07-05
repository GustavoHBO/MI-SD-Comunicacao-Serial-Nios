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
	wire [7:0] mode_configurate;
	
	reg [1:0] modo;
	
	initial modo = 2'b00;
	
	assign led = ~data[3:0];
	//assign tx = rx;
	
	clk_divider clk_divider (
		.clk_in(clk),
		.rst(~reset),
		.clk_out(clk_speed),
		.pulse(pulse_configure),
		.speed(configuration[5:4])
	);
	
	 control_uart control_uart(
	 	.clk(clk),
	 	.dataReady(),
	 	.rst(~reset),
	 	.dataIn(mode_configurate),
	 	.dataOut(configuration),
		.pulse(pulse_configuration),
		.dataReady(~button),
		.packet(data_packet_wire),
		.pulse_configure(pulse_configure)
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
		 
	processor processor (
        .clk_clk         (clk),         //      clk.clk
        .reset_reset_n   (1'b1),   //    reset.reset_n
        .switches_export (), // switches.export
        .leds_export     (),     //     leds.export
        .modo_lcd_export (),  // modo_lcd.export
		  .modo_serial_export (mode_configurate)
	);
endmodule