//www.21eda.com
//?????LCD1602??????LCD
//????
//????????21EDA????????
module LCD1602(clk, rs, rw, en,dat,LCD_N,LCD_P, modooperacao);
 
 input [7:0] modooperacao;
 
 
 input clk;  
 output [7:0] dat; 
 output  rs,rw,en,LCD_N,LCD_P; 
 //tri en; 
 reg e; 

 reg [7:0] dat; 
 reg rs;   
 reg  [15:0] counter; 
 reg [4:0] current,next; 
 reg clkr; 
 reg [1:0] cnt; 
 reg [4:0] contador;
 parameter  set0=4'h0; 
 parameter  set1=4'h1; 
 parameter  set2=4'h2; 
 parameter  set3=4'h3; 
 parameter  set4=4'h11;
 parameter  dat0=4'h4; 
 parameter  dat1=4'h5; 
 parameter  dat2=4'h6; 
 parameter  dat3=4'h7; 
 parameter  dat4=4'h8; 
 parameter  dat5=4'h9; 

 parameter  dat6=4'hA; 
 parameter  dat7=4'hB; 
 parameter  dat8=4'hC; 
 parameter  dat9=4'hD; 
 parameter  dat10=4'hE; 
 parameter  dat11=5'h10; 
 
 parameter  nul=4'hF; 
 assign LCD_N=0;
 assign LCD_P=1;
  
always @(posedge clk)      
 begin 
  counter=counter+1; 
  if(counter==16'h000f)  
  clkr=~clkr; 
end 

always @(posedge clkr) 
begin 
 current<=next; 
  case(current) 
    set0:   begin  rs<=0; dat<=8'h31; next<=set1; end  //*??8???,2?,5*7*
    set1:   begin  rs<=0; dat<=8'h0C; next<=set2; end  //*????,???,???*/  
    set2:   begin  rs<=0; dat<=8'h6; next<=set3; end   //*??????,?????*/  
    set3:   begin  rs<=0; dat<=8'h1; next<=dat0; end   //*????*/    

    dat0:   begin  rs<=1; dat<="W"; next<=dat1; end 
    dat1:   begin  rs<=1; dat<="a"; next<=dat2; end 
    dat2:   begin  rs<=1; dat<="v"; next<=dat3; end 
    dat3:   begin  rs<=1; dat<="e"; next<=dat4; end 
    dat4:   begin  rs<=1; dat<="s"; next<=dat5; end 
    dat5:   begin  rs<=1; dat<="h"; next<=dat6; end 
    dat6:   begin  rs<=1; dat<="a"; next<=dat7; end 
    dat7:   begin  rs<=1; dat<="r"; next<=dat8; end 
    dat8:   begin  rs<=1; dat<="e"; next<=dat9; end 
    dat9:   begin  rs<=1; dat<="a"; next<=dat10; end 
    dat10:   begin  rs<=1; dat<="b"; next<=nul; end 
	 nul: begin  rs=0; dat<=modooperacao; next<=nul; end
    //?????12??????????  
          // next=set0; 
    endcase 
end
assign en=clkr|e; 
assign rw=0; 
endmodule  







// Quartus II Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)

module four_state_moore_state_machine
(
	input	clk, in, reset,
	output reg [1:0] out
);

	// Declare state register
	reg		[1:0]state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
				out = 2'b01;
			S1:
				out = 2'b10;
			S2:
				out = 2'b11;
			S3:
				out = 2'b00;
			default:
				out = 2'b00;
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					state <= S1;
				S1:
					if (in)
						state <= S2;
					else
						state <= S1;
				S2:
					if (in)
						state <= S3;
					else
						state <= S1;
				S3:
					if (in)
						state <= S2;
					else
						state <= S3;
			endcase
	end

endmodule
