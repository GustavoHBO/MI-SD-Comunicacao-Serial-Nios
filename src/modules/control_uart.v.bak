module control_uart(
				clk,
				dataReady,
				rst,
				dataIn,
				dataOut
);

	input clk;
	input dataReady;
	input rst;
	input [7:0] dataIn;
	output [7:0] dataOut;

	reg [7:0] configuration;
	reg [1:0] state;
	reg [7:0] dataCache;

	localparam reset = 2'b0, idle = 2'b01, configure = 2'b11, done = 2'b10;

	always @ (posedge clk) begin
		if (rst) begin
			state <= reset;
		end else begin
			case (state)
				reset:begin
					configuration <= 8'b00001100;
					state <= idle;
				end
				idle:begin
					if(dataReady) begin
						dataCache <= dataIn;
						state <= configure;
					end
				end
				configure:begin
					if(dataCache[5:4] == 2'b10) state <= idle;
					else begin
						configuration <= dataCache;
						state <= done;
					end
				end
				done:begin
					state <= idle;
				end
			endcase
		end
	end
endmodule