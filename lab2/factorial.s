	.text
	.global _start
_start:
	LDR R0, N		//RESULT
	LDR R1, N		//STORE THE CURRENT N
	BL FACTORIAL	//call the factorial subroutine
	B END

FACTORIAL:
	CMP R1, #0		//check whetehr R1 equals to 0
	MOVEQ R0, #1	//set the return value to 1, if R1 is 0
	BXEQ LR			//return to the caller

	//IF N != 0
	PUSH {R1}		//push the current n value on the stack
	SUB R1, R1, #1	//update the n for next factorial call
	PUSH {LR}		//push the returning instruction to the stack
	BL FACTORIAL	//call the factorial subroutine
	POP {LR}		//get the address of instruction from the stack
	POP {R3}		//get the current n from the stack
	MUL R0, R3, R0	//multiply the n with the returning result from recursion
	BX LR			//return to the caller

END:
	B END
	
N: .word	0
