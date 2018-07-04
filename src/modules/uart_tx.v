module uart_tx(data, reset, clk, ready, tx);
	
	input clk;
	input reset;
	input [7:0] data;
	input ready;
	
	output reg tx;
	
	reg [3:0] counter;
	reg [7:0] dataA;
	
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