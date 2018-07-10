.data
.text
	

.global _start 
_start:	

		call grava_modos

grava_modos:	
		movia r7, 0x3040
		movia r8, 0x3050
		movia r9, 0b00001110
		movia r10, 0b00010000
		stb r9, 0(r8)
		stb r10, 0(r7)
		call end

end:
	br end
.end
