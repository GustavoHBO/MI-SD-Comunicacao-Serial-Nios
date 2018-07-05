module receiver(
    input Clock, 
    input Reset, 
    input Rx,
    output ShiftRegister,

);


parameter FrequenciaClock = 50000000;
parameter BaudRate = 9600;
parameter LimiteClock = 2604;


wire Edge;
wire Start;
wire Tick;

assign Start = !Rx;

reg[9:0] Shift;
reg[12:0] ContadorClock;
reg[3:0] ContadorDados;
reg[1:0] Estado;

parameter Reset = 0, Start = 1, Dados = 2, Stop = 3;

always @(posedge Clock) begin 
   // ContadorClock <= (ContadorClock == LimiteClock) ? 0: ContadorClock = ContadorClock + 1;
   if(ContadorClock == LimiteClock) {
       Clock = ~Clock; //Inverte clock 
       ContadorClock <= 0;
   } else {
       ContadorClock <= ContadorClock + 1; //Conta
   }
end
 


always @(posedge Clock) begin
  case (Estado)
    Reset: 
        if(Start == 0) begin
            Estado <= Dados;
        end else 
            Estado <= Reset;
        end
    Start: 
        ContadorDados = 0;
        Estado <= Dados;
    Dados:
        if(ContadorDados == 8) begin
            Estado <= Stop
        end
        else begin
            ContadorDados = ContadorDados + 1;
        end
    Stop:
        Estado <= Reset;
    default: 
  endcase
end
