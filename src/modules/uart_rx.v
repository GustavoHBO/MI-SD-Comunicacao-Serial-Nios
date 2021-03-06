module uart_rx(rx, rst, pulse, configuration, clk, data, ready);
	
	input rx;
	input clk;
	input rst;
	input pulse;
	input [1:0]configuration;
	
	output reg [7:0] data;
	output reg ready;
	
	reg [3:0] counter;
	reg [7:0] dataA;
	reg [3:0] data_size;
	reg [1:0] state;
	
	localparam reset= 2'b00, idle = 2'b01, receving = 2'b11, done = 2'b10;
	
	always @ (posedge clk) begin
			if (rst) begin
				state <= idle;
				ready <= 1'b0;
				data  <= 8'd0;
			end else begin
				case (state)
					reset:begin
					data_size <= 4'd7;
					end
					idle:begin
						ready <= 1'b0;
						if(pulse)begin
							if(configuration == 2'b00) data_size <= 4'd7;
							if(configuration == 2'b01) data_size <= 4'd6;
							if(configuration == 2'b11) data_size <= 4'd5;
							if(configuration == 2'b10) data_size <= 4'd4;
						end
						if (!rx) begin
							state   <= receving;
							counter <= 4'd0;
						end else begin
							state <= idle;
						end
					end
					receving:begin
						if (counter == data_size) begin
							dataA[counter] <= rx;
							//counter <= counter + 1'd1;
							state <= done;
						end else begin
							dataA[counter] <= rx;
							counter <= counter + 1'd1;
							state <= receving;
						end
					end
					done:begin
						ready <= 1'b1;
						state <= idle;
						data <= dataA;
					end
				endcase
			end
	end
	
endmodule