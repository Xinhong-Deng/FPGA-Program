.text
	.global _start
_start:
	LDR R4,=NUMBERS	//R4 points to the result location
	LDR R1,[R4]
	LDR R2,[R4, #4]	//R0 holds the number of elements in the list
	LDR R3,[R4, #8]	//R3 points to the first number
	BL FINDMIN
	B END

FINDMIN:
	CMP R1,R2
	MOVGE R1,R2
	CMP R1,R3
	MOVGE R1,R3
	BX LR
	

END:		B END		//infinite loop!


NUMBERS:	.word	4,5,3	// the list data
		

