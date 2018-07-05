.data
.text
	

.global _start 
_start:	

		call grava_modos

grava_modos:	
		movia r8, 0x3010
		movia r9, 0b01010101
		stb r9, 0(r8)
		call end

end:
	br end
.end
