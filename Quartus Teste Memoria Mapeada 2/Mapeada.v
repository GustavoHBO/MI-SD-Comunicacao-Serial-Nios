module Mapeada(clk, led, rs, rw, en, dat, LCD_N, LCD_P);
input clk;
output rs,rw,en,LCD_N,LCD_P; 
output [7:0] dat;
output [3:0] led;

wire [7:0] lcd_processador;
assign led =~lcd_processador[7:4];

 processor processor (
        .clk_clk         (clk),         //      clk.clk
        .reset_reset_n   (1'b1),   //    reset.reset_n
        .switches_export (), // switches.export
        .leds_export     (),     //     leds.export
        .modo_lcd_export (lcd_processador)  // modo_lcd.export
 );


 
LCD1602 LCD1602_inst
(
	.clk(clk) ,	// input  clk_sig
	.rs(rs) ,	// output  rs_sig
	.rw(rw) ,	// output  rw_sig
	.en(en) ,	// output  en_sig
	.dat(dat) ,	// output [7:0] dat_sig
	.LCD_N(LCD_N) ,	// output  LCD_N_sig
	.LCD_P(LCD_P) ,	// output  LCD_P_sig
	.modooperacao(lcd_processador) 	// input [7:0] modooperacao_sig
);

endmodule