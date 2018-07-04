.data
.text
	movia r8, 0x301F
	movia r9, 0b00001111

.global _start 
_start:

		call grava_modos

grava_modos:	
		stb r9, 0(r8)
		call end

end:
	br end
.end