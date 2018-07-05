//www.21eda.com
//?????LCD1602??????LCD????
//????????21EDA????????
module LCD1602(clk, rs, rw, en,dat,LCD_N,LCD_P);  
input clk;
 output [7:0] dat; 
 output  rs,rw,en,LCD_N,LCD_P;
 //tri en;
 reg [63:0] hex;
 reg e; 
 reg [7:0] dat; 
 reg rs;   
 reg  [15:0] counter; 
 reg [4:0] current,next; 
 reg clkr; 
 reg [1:0] cnt;
 reg result;
 initial result = 1'b1;
//‭ABCD‬EFAB em hexa
reg[31:0] crc;
initial crc = 32'b10101011110011011110111110101011;     //‭‭‭10101011110011011110111110101011;

 parameter  set0=4'h0; 
 parameter  set1=4'h1; 
 parameter  set2=4'h2; 
 parameter  set3=4'h3;

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
  
integer contador = 63;
integer index;

always @* begin
for(index = 0; index < 8; index = index+1) begin
	case(crc[contador-:7])
		4'b0000: hex[contador-:7] <= 8'd30; //0
		4'b0001: hex[contador-:7] <= 8'd31; //1
		4'b0010: hex[contador-:7] <= 8'd32; //2
		4'b0011: hex[contador-:7] <= 8'd33; //3
		4'b0100: hex[contador-:7] <= 8'd34; //4
		4'b0101: hex[contador-:7] <= 8'd35; //5
		4'b0110: hex[contador-:7] <= 8'd36; //6
		4'b0111: hex[contador-:7] <= 8'd37; //7
		4'b1000: hex[contador-:7] <= 8'd38; //8
		4'b1001: hex[contador-:7] <= 8'd39; //9
		4'b1010: hex[contador-:7] <= 8'd65; //A
		4'b1011: hex[contador-:7] <= 8'd66; //B
		4'b1100: hex[contador-:7] <= 8'd67; //C
		4'b1101: hex[contador-:7] <= 8'd68; //D
		4'b1110: hex[contador-:7] <= 8'd69; //E
		4'b1111: hex[contador-:7] <= 8'd70; //F
	endcase
	contador = contador - 8;
end
end

always @(posedge clk)      
 begin 
  counter=counter+1; 
  if(counter==16'h000f)  
  clkr=~clkr; 
end



always @(posedge clkr) 
begin 
 current=next;
 if(result) begin
  case(current) 
    set0:   begin  rs<=0; dat<=8'h31; next<=set1; end  
    set1:   begin  rs<=0; dat<=8'h0C; next<=set2; end   
    set2:   begin  rs<=0; dat<=8'h6; next<=set3; end    
    set3:   begin  rs<=0; dat<=8'h1; next<=dat0; end     

    dat0:   begin  rs<=1; dat<="C"; next<=dat1; end 
    dat1:   begin  rs<=1; dat<=" "; next<=dat2; end 
    dat2:   begin  rs<=1; dat<=hex[63:56]; next<=dat3; end 
    dat3:   begin  rs<=1; dat<=hex[55:48]; next<=dat4; end 
    dat4:   begin  rs<=1; dat<=hex[47:40]; next<=dat5; end 
    dat5:   begin  rs<=1; dat<=hex[39:32]; next<=dat6; end 
    dat6:   begin  rs<=1; dat<=hex[31:24]; next<=dat7; end 
    dat7:   begin  rs<=1; dat<=hex[23:16]; next<=dat8; end 
    dat8:   begin  rs<=1; dat<=hex[15:8]; next<=dat9; end 
    dat9:   begin  rs<=1; dat<=hex[7:0]; next<=dat10; end 
    dat10:   begin  rs<=1; dat<=" "; next<=dat11; end 
    dat11:   begin  rs<=1; dat<=" "; next<=nul; end 
    
    nul: begin rs<=0; dat<=8'b00001111; next<=nul; end    
 
    endcase
	 end
	 
	 else begin
	 case(current)
		 set0:   begin  rs<=0; dat<=8'h31; next<=set1; end  
		 set1:   begin  rs<=0; dat<=8'h0C; next<=set2; end   
		 set2:   begin  rs<=0; dat<=8'h6; next<=set3; end    
		 set3:   begin  rs<=0; dat<=8'h1; next<=dat0; end     

		 dat0:   begin  rs<=1; dat<="E"; next<=dat1; end 
		 dat1:   begin  rs<=1; dat<=" "; next<=dat2; end 
		 dat2:   begin  rs<=1; dat<=hex[63:56]; next<=dat3; end 
		 dat3:   begin  rs<=1; dat<=hex[55:48]; next<=dat4; end 
		 dat4:   begin  rs<=1; dat<=hex[47:40]; next<=dat5; end 
		 dat5:   begin  rs<=1; dat<=hex[39:32]; next<=dat6; end 
		 dat6:   begin  rs<=1; dat<=hex[31:24]; next<=dat7; end 
		 dat7:   begin  rs<=1; dat<=hex[23:16]; next<=dat8; end 
		 dat8:   begin  rs<=1; dat<=hex[15:8]; next<=dat9; end 
		 dat9:   begin  rs<=1; dat<=hex[7:0]; next<=dat10; end 
		 dat10:   begin  rs<=1; dat<=" "; next<=dat11; end 
		 dat11:   begin  rs<=1; dat<=" "; next<=nul; end 
			 
		 nul: begin rs<=0; dat<=8'b00001111; next<=nul; end
	 endcase
	 end
 end 
assign en=clkr|e; 
assign rw=0; 
endmodule  