	.text
	.global _start
_start:
	LDR R4, =SUM				//R4 points to the SUM result location
	LDR R1, =MAXPRODUCT			//R1 points to the MAXPRODUCT location
	LDR R9, =MINPRODUCT			//R9 points to the MINPRODUCT location
	LDR R2, [R4, #12]			//R2 holds the number of elements in the list
	ADD R3, R4, #16				//R3 points to the first number s1
	LDR R0, [R3]				//R0 holds the first number in the list
	LDR R10, =SUMPAIRS			//R10 points to the SUMPAIRS location
	
CALCULATESUMPAIRS:
    MOV R12, R10 				//R12 points to the SUMPAIRS location
	LDR R5, [R4, #16]			//R5 stores the first number s1
	LDR R6, [R4, #20]			//R6 stores the second number s2
	LDR R7, [R4, #24]			//R7 stores the third number s3
	LDR R11, [R4, #28]			//R11 stores the fourth number s4
	ADD R8, R5, R6				//R8 stores the the sum of s1+s2
	STR R8, [R12], #4			//store the value of R8 in the memory, and increment the address of R12 by four bytes
	ADD R8, R5, R7				//R8 stores the the sum of s1+s3
	STR R8, [R12], #4			//store the value of R8 in the memory, and increment the address of R12 by four bytes
	ADD R8, R6, R7				//R8 stores the the sum of s2+s3
	STR R8, [R12], #4			//store the value of R8 in the memory, and increment the address of R12 by four bytes
	ADD R8, R5, R11				//R8 stores the the sum of s1+s4
	STR R8, [R12], #4			//store the value of R8 in the memory, and increment the address of R12 by four bytes	
	ADD R8, R6, R11				//R8 stores the the sum of s2+s4
	STR R8, [R12], #4			//store the value of R8 in the memory, and increment the address of R12 by four bytes
	ADD R8, R7, R11				//R8 stores the the sum of s3+s4
	STR R8, [R12], #4			//store the value of R8 in the memory, and increment the address of R12 by four bytes
	MOV R12, R10				//let R12 stores the address of the SUMPAIRS
	LDR R5, [R12]				//let R5 stores the the value of s1+s2
	MOV R11, #6					//let R11 stores the valur of 6

SUMLOOP: 	
	SUBS R2, R2, #1				//let R2 substract 1 for each loop
	BEQ SUMDONE					//when R2 equals zero, flag Z equals 1. Then execute the label SUMDONE
	LDR R6, [R3,#4]!			//let R6 have the value of the next number in the list
	ADD R0, R0, R6				//let the sum of the numbers be the sum of sum and the next number
	B SUMLOOP					//back to the sumloop

PRODUCTLOOP: 					//This loop compares the 6 combinations of numbers.
	SUBS R11, R11, #1			//R11 deceases by 1 for each loop
	BEQ PRODUCTDONE				//if R11 equals to 0, flag z equals to 1. Then execute the lable PRODUCTDONE. 
	LDR R5, [R12], #4			//Let the R5 stores the sum of next combination of numbers
	SUBS R6, R0, R5				//Let the R6 stores the sum of the other two numbers in the list
	MUL R7, R5, R6				//R7 stores the product of two sums 
	CMP R3, R7					//Justify if the current product is not less than the max
	BLE UPDATEMAX				//if yes, execute the UPDATEMAX
FINDMIN:		
	CMP R2, R7					//check if it is less than the minimum
	BGE UPDATEMIN				//if yes, update the current min
	B PRODUCTLOOP 				//branch back to the loop
		

SUMDONE:		
	STR R0, [R4]				//stores the value of sum in R0
	LDR R6, [R12]				//stores the value the sum of two numbers in the list(LOOP all 6 combinations)
	SUBS R7, R0, R6				//R7 stores the sum of the other two numbers
	MUL R6, R6, R7				//R6 stores the product of two sums of combinations
	MOV R3, R6					//R3 stores the first product as MAX
	MOV R2, R6					//R2 stores the first product as MIN
	B PRODUCTLOOP 				//branch back to the productloop

PRODUCTDONE:
	STR R3, [R1]				//let MAXPRODUCT stores the current max product
	STR R2, [R9]				//let MINPRODUCT stores the current min product
END:		
	B END						//infinite loop!

UPDATEMAX: 	
			MOV R3, R7			//update the current max(R3 is the current max, R7 is the current product)
			B FINDMIN			//branch back to label findmin

UPDATEMIN: 
			MOV R2, R7			//update the current min(R2 is the current max, R7 is the current product)
			B PRODUCTLOOP		//branch back to label productloop

SUM:				.word	0	//memory assigned for result location
MINPRODUCT: 		.word 	0	//minproduct equals to 0
MAXPRODUCT: 		.word 	0	//maxproduct equals to 0
N:			.word 	4			//number of ntries in the list
NUMBERS:	.word	-2,9,6,3		// the list data
SUMPAIRS: 	.word	0			//pair of sums

