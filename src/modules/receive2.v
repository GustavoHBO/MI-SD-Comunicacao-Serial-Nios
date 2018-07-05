module receiver2(
    input clock, 
    input reset, 
    input rx,
    output data,
    output pulse,
);


parameter FrequenciaClock = 50000000;
parameter BaudRate = 9600;
parameter LimiteClock = 2604;


reg[9:0] rx;
reg[3:0] contadorDados;
reg[1:0] estado;

parameter reset = 0, start = 1, dados = 2, stop = 3;


always @(posedge clock) begin
  case (estado)
    reset: 
        if(start == 0) begin
            estado <= dados;
        end else 
            estado <= reset;
        end
    start: 
        contadorDados = 0;
        estado <= dados;
    dados:
        if(contadorDados == 8) begin
            estado <= stop;
        end
        else begin
            contadorDados = contadorDados + 1;
        end
    stop:
        estado <= reset;
    default: 
  endcase
end
