module receiver(
    input Clock, 
    input Reset, 
    input Rx,
    output [7:0] ShiftRegister
);



parameter FrequenciaClock = 50000000;
parameter BaudRate = 9600;
parameter LimiteClock = 2604;

reg Dados_Prontos;
wire Edge;
wire Start;
wire Tick;
reg Clk;
//wire Dados_Prontos;


assign Start = Rx;

reg[7:0] Shift;
reg[12:0] ContadorClock;
reg[3:0] ContadorDados;
reg[1:0] Estado;

assign ShiftRegister = Shift;
parameter Repouso = 0, Start_Bit = 1, Dados = 2, Stop = 3;

always @(posedge Clock) begin 
   if(ContadorClock == LimiteClock) begin
       Clk = ~Clk; //Inverte clock 
       ContadorClock <= 0;
   end else begin
       ContadorClock <= ContadorClock + 1; //Conta
   end
end


 


always @(posedge Clk) begin
	  case (Estado)
		 Repouso: 
			  if(Start == 0) begin
					Estado <= Dados;
			  end else begin
					Estado <= Reset;
			  end
		 Start_Bit:  begin
			  ContadorDados = 0;
			  Estado <= Dados;
			  end
		 Dados: 
			  if(ContadorDados == 8) begin
					Estado <= Stop;
			  end
			  else begin
					ContadorDados = ContadorDados + 1;
					Shift <= {Shift[7:0], Rx};
			  end
		 Stop: begin
			  Estado <= Reset;
			  Dados_Prontos = 1;
			  end
	  endcase
  end
endmodule