module clk_divider (clk_in, rst, pulse, speed, clk_out);

	input clk_in;
	input rst;
	input pulse;
	input [1:0]speed;
	
	output reg clk_out;
	
	reg [11:0] counter;
	reg [11:0] counter_time;
	reg [1:0] state;
	reg [1:0] speedCache;
	
	localparam reset = 2'b00, idle = 2'b01, configure = 2'b11, done = 2'b10;

	always @ (posedge clk_in) begin
		if (rst) begin
			state <= reset;
		end else begin
			case (state)
				reset:begin
					counter <= 12'b0;
					counter_time <= 12'd2604;
					state <= idle;
				end
				idle:begin
					if(pulse) begin
						speedCache <= speed;
						state <= configure;
					end
					else if (counter > counter_time) begin
						clk_out <= ~clk_out;
						counter <= 12'd0;
					end else begin
						counter <= counter + 12'd1;
					end
				end
				configure:begin
					if(speedCache == 2'b00) counter_time <= 12'd2604;
					if(speedCache == 2'b01) counter_time <= 12'd1302;
					if(speedCache == 2'b11) counter_time <= 12'd434;
					if(speedCache == 2'b10) counter_time <= 12'd217;
					state <= done;
				end
				done: state <= idle;
			endcase
		end
	end 
endmodule