module NovoQuartus (clk, botao, led, rs, rw, en, dat, LCD_N, LCD_P);
input clk, botao;
output dat, rs,rw,en,LCD_N,LCD_P;
output [3:0] led;
wire [3:0] out;
wire [7:0] lcd_processador;
assign led = ~out;


 processador u0 (
        .clk_clk         (clk),         //      clk.clk
        .reset_reset_n   (1'b1),   //    reset.reset_n
        .ledout_export   (out),   //   ledout.export
        .botaoout_export (~botao),  // botaoout.export
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
