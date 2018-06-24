//LCD1602
module LCD1602(
                clk, 
                rs, 
                rw, 
                en,
                dat,
                LCD_N,
                LCD_P,
                mode);  
                
    input clk;  
    input [1:0]mode;// 00 - Normal, 01 - Piscar, 10 - Acender e pisca 
    output [7:0] dat; 
    output  rs,rw,en,LCD_N,LCD_P; 
    //tri en; 
    reg e; 
    reg [7:0] dat; 
    reg rs;   
    reg  [15:0] counter; 
    reg [4:0] current, next; 
    reg clkr; 
    reg [1:0] cnt; 

    reg [26:0] delay;
    reg [26:0] timeDelay = 21'b101111101011110000100;
    reg blink = 0;

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

    always @(posedge clk) begin 
        counter=counter+1; 
        if(counter==16'h000f)  
            clkr=~clkr; 
    end 
    always @(posedge clkr) begin 
        current=next; 
        case(current) 
            set0:   begin  rs<=0; dat<=8'h31; next<=set1; end  //*??8???,2?,5*7*
            set1:   begin  rs<=0; dat<=8'h0C; next<=set2; end  //*????,???,???*/  
            set2:   begin  rs<=0; dat<=8'h6; next<=set3; end   //*??????,?????*/  
            set3:   begin  rs<=0; dat<=8'h1; next<=dat0; end   //*????*/    

            //???LCD????
            dat0:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="F"; 
                else dat<=" ";
                next<=dat1;
            end
            dat1:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="r"; 
                else dat<=" ";
                next<=dat2;
            end
            dat2:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="a"; 
                else dat<=" ";
                next<=dat3;
            end
            dat3:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="n"; 
                else dat<=" ";
                next<=dat4;
            end 
            dat4:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<=" "; 
                else dat<=" ";
                next<=dat5;
            end 
            dat5:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="F"; 
                else dat<=" ";
                next<=dat6;
            end
            dat6:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="r"; 
                else dat<=" ";
                next<=dat7;
            end 
            dat7:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="a"; 
                else dat<=" ";
                next<=dat8;
            end 
            dat8:   begin  
                rs<=1;
                if(mode == 2'b01) begin
                    delay = delay+1;
                    if(delay == timeDelay) begin
                        blink = ~blink;
                        delay = 26'b0;
                    end
                end
                if(mode == 2'b10) begin
                    delay = delay+1;
                    if(delay == timeDelay/2) begin
                        blink = 0;
                    end
                    if(delay == (8*timeDelay)/12) blink = ~blink;
                    if(delay == (5*timeDelay)/6) blink = ~blink;
                    if(delay == timeDelay) blink = ~blink;
                end
                if(mode == 2'b00 || ~blink) dat<="n"; 
                else dat<=" ";
                next<=dat9;
            end 
            dat9:   begin  rs<=1; dat<=" "; next<=dat10; end 
            dat10:   begin  rs<=1; dat<=" "; next<=dat11; end 
            dat11:   begin  rs<=1; dat<=" "; next<=nul; end 
            //?????12??????????
            nul:   begin 
                rs<=0;  
                dat<=8'h00;
                if(cnt!=2'h2)  
                    begin  
                        e<=0;next<=set0;cnt<=cnt+1;  
                    end  
                    else  
                        begin next<=nul; e<=1; 
                        end    
                end 
            default:   next=set0; 
        endcase 
    end 
    assign en=clkr|e; 
    assign rw=0; 
endmodule  