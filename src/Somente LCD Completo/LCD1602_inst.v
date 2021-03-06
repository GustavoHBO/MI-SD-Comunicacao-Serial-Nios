// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.


// Generated by Quartus II 64-Bit Version 13.1 (Build Build 162 10/23/2013)
// Created on Wed Jul  4 17:55:44 2018

LCD1602 LCD1602_inst
(
	.clk(clk_sig) ,	// input  clk_sig
	.rs(rs_sig) ,	// output  rs_sig
	.rw(rw_sig) ,	// output  rw_sig
	.en(en_sig) ,	// output  en_sig
	.dat(dat_sig) ,	// output [7:0] dat_sig
	.LCD_N(LCD_N_sig) ,	// output  LCD_N_sig
	.LCD_P(LCD_P_sig) ,	// output  LCD_P_sig
	.modooperacao(modooperacao_sig) 	// input [7:0] modooperacao_sig
);

defparam LCD1602_inst.set0 = 'b0000;
defparam LCD1602_inst.set1 = 'b0001;
defparam LCD1602_inst.set2 = 'b0010;
defparam LCD1602_inst.set3 = 'b0011;
defparam LCD1602_inst.dat0 = 'b0100;
defparam LCD1602_inst.dat1 = 'b0101;
defparam LCD1602_inst.dat2 = 'b0110;
defparam LCD1602_inst.dat3 = 'b0111;
defparam LCD1602_inst.dat4 = 'b1000;
defparam LCD1602_inst.dat5 = 'b1001;
defparam LCD1602_inst.dat6 = 'b1010;
defparam LCD1602_inst.dat7 = 'b1011;
defparam LCD1602_inst.dat8 = 'b1100;
defparam LCD1602_inst.dat9 = 'b1101;
defparam LCD1602_inst.dat10 = 'b1110;
defparam LCD1602_inst.dat11 = 'b10000;
defparam LCD1602_inst.nul = 'b1111;
