module control_uart(
				clk,
				dataReady,
				rst,
				dataIn,
				dataOut,
				pulse
);

	input clk;
	input dataReady;
	input rst;
	input [7:0] dataIn;
	output [7:0] dataOut;
	output reg pulse;

	reg [7:0] configuration;
	reg [1:0] state;
	reg [7:0] dataCache;

	localparam reset = 2'b0, idle = 2'b01, configure = 2'b11, done = 2'b10;

	always @ (posedge clk) begin
		if (rst) begin
			pulse = 1'b0;
			state <= reset;
		end else begin
			case (state)
				reset:begin
					configuration <= 8'b00001100;
					state <= idle;
				end
				idle:begin
				pulse = 1'b0;
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
					pulse = 1'b1;
					state <= idle;
				end
			endcase
		end
	end
endmodule