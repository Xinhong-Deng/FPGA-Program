	.text
	.global _start
_start:
	LDR R4, =RANGE			//R4 points to the range result location
	LDR R2, [R4, #4]		//R2 holds the number of elements in the list
	ADD R3, R4, #8			//R3 points to the first number
	LDR R0, [R3]			//R0 holds the first number in the list
	LDR R6, [R3]			//R6 holds the first number in the list

LOOP:	
	SUBS R2, R2, #1			//decrement the loop counter
	BEQ DONE				//end loop if counter has reached 0
	ADD R3, R3, #4			//R3 points to next number in the list
	LDR R1, [R3]			//R1 holds the next number in the list
	CMP R0, R1				//check if it is grerater than the maximum
	BLE UPDATEMAX			//if yes, update the current max
FINDMIN:		
	CMP R6, R1				//check if it is less than the minimum
	BGE UPDATEMIN			//if yes, update the current min
	B LOOP 					//branch back to the loop
		

DONE:		
	SUBS R7, R0, R6			//calculate the range by substract the min from the max
	STR R7, [R4]			//store the range to memory location

END:
	B END					//infinite loop!

UPDATEMAX: 	
	MOV R0, R1				//let R0 have the value of current max
	B FINDMIN				//branch back to the label FINDMIN

UPDATEMIN: 
	MOV R6, R1				//let R6 have the value of current min
	B LOOP					//branch back to the loop

RANGE:		.word 0			//memory assigned for result location
N:			.word 7			//number of ntries in the list
NUMBERS:	.word	90,4,11,250	// the list data
			.word 	8,8,-6
