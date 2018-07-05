module NovoQuartus (clk, led, rs, rw, en, dat, LCD_N, LCD_P);
input clk;
output rs,rw,en,LCD_N,LCD_P;
output [7:0] dat;
output [3:0] led;


wire [7:0] outlcd;
wire [7:0] lcd_processador;
assign led = ~lcd_processador[7:4];
 processador u0 (
        .clk_clk         (clk),         //      clk.clk
        .reset_reset_n   (1'b1),   //    reset.reset_n
		  .modooperacao_export (lcd_processador)
    );

	 
LCD1602 lcd(
	.clk (clk),
	.rs (rs),
	.rw (rw),
	.en (en),
	.dat (dat),
	.LCD_N (LCD_N),
	.LCD_P (LCD_P),
	.modooperacao(lcd_processador)
);


endmodule 
