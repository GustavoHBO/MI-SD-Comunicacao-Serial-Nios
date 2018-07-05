module control_uart(
				clk,
				dataReady,
				packet_receive,
				pulse_receive,
				rst,
				dataIn,
				dataOut,
				pulse,
				packet,
				pulse_packet,
				pulse_configure
);

	input clk;
	input dataReady;
	input rst;
	input [7:0] dataIn;
	input [7:0] packet_receive;
	input pulse_receive;
	
	output [7:0] dataOut;
	output reg pulse;
	output reg pulse_configure;
	output reg [31:0] packet;
	output reg pulse_packet;

	reg [7:0] configuration;
	reg [31:0] data_packet;
	reg [2:0] state;
	reg [7:0] dataCache;
	reg [2:0] count_packet;

	localparam reset = 3'b000, idle = 3'b001, configure = 3'b011, done = 3'b010, mount_packet = 3'b110, data_packet_ok = 3'b111;

	always @ (posedge clk) begin
		if (rst) begin
			pulse = 1'b0;
			count_packet <= 3'b000;
			pulse_configure <= 1'b0;
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
					end else if(pulse_receive)begin
						data_packet <= packet_receive;
						state <= mount_packet;
					end
				end
				configure:begin
					if(dataCache[5:4] == 2'b10) state <= idle;
					else begin
						configuration <= dataCache;
						pulse_configure <= 1'b1;
						state <= done;
					end
				end
				mount_packet:begin
					count_packet <= count_packet + 1'b1;
					if(configuration == 2'b00)begin
						if(count_packet == 3'b001)begin
							data_packet[5'd7:5'd0] <= packet_receive;
						end else if (count_packet == 3'b010) begin
							data_packet[5'd15:5'd8] <= packet_receive;
						end else if (count_packet == 3'b011) begin
							data_packet[5'd23:5'd16] <= packet_receive;
						end else if (count_packet == 3'b011) begin
							data_packet[5'd31:5'd24] <= packet_receive;
							state <= data_packet_ok;
						end
					end
					if(configuration == 2'b01) 
					if(configuration == 2'b11) 
					if(configuration == 2'b10) 
					state <= done;
				end
				data_packet_ok:begin
					count_packet <= 3'b000;
					pulse_packet <= 1'b1;
					packet <= data_packet;
					state <= done;
				end
				done:begin
					pulse_packet <= 1'b0;
					pulse_configure <= 1'b0;
					pulse = 1'b1;
					state <= idle;
				end
			endcase
		end
	end
endmodule