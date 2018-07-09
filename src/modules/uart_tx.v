module uart_tx(data, reset, pulse, configuration, clk, ready, tx);
	
	input clk;
	input reset;
	input [7:0] data;
	input ready;
	input pulse;
	input [1:0] configuration;
	
	output reg tx;
	
	reg [3:0] counter;
	reg [7:0] dataA;
	reg [3:0] data_size;
	reg [1:0] state;
	
	localparam idle= 2'b00, sending = 2'b01, done = 2'b11; 
	
	always @ (posedge clk) begin
			if (reset) begin
				state <= idle;
				tx <= 1'b1;
			end else begin
				case (state)
					idle:begin
						tx <= 1'b1;
						if(pulse)begin
							if(configuration == 2'b00) data_size <= 4'd7;
							if(configuration == 2'b01) data_size <= 4'd6;
							if(configuration == 2'b11) data_size <= 4'd5;
							if(configuration == 2'b10) data_size <= 4'd4;
						end
						if (ready) begin
							dataA <= data;
							state   <= sending;
							tx <= 1'b0;
							counter <= 4'd0;
						end else begin
							state <= idle;
						end
					end
					sending:begin
						if (counter == 4'd7) begin
							tx <= dataA[counter];
							state <= done;
						end else begin
							tx <= dataA[counter];
							counter <= counter + 1'd1;
							state <= sending;
						end
					end
					done:begin
						tx <= 1'b1;
						state <= idle;
					end
				endcase
			end
	end
	
endmodule