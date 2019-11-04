.text
.equ PUSHBUTTON_BASE, 0x10000050
.equ PUSHBUTTON_INTERRUPTION, 0x10000058
.equ PUSHBUTTON_EDGECAPTURE, 0x1000005C
.global read_PB_data_ASM, PB_data_is_pressed_ASM, read_PB_edgecap_ASM, PB_edgecap_is_pressed_ASM, PB_clear_edgecap_ASM, enable_PB_INT_ASM, disable_PB_INT_ASM

read_PB_data_ASM:
LDR R1, =PUSHBUTTON_BASE
LDR R0, [R1]
BX LR

PB_data_is_pressed_ASM:
//R0 parameter from C
LDR R1, =PUSHBUTTON_BASE
LDR R2, [R1]			//value of the data register

CMP R0, #1				//Check whether parameter is pb0
ANDEQ R3, R2, #1		//get the 0 bit value
CMP R3, #1				//check whether the 0 bit is 1
MOVEQ R0, #1
BXEQ LR

CMP R0, #2				//Check whether parameter is pb1
LSR R2, R2, #1			
ANDEQ R3, R2, #1		//get the BIT1 value
CMP R3, #1				//check whether the BIT1 is 1
MOVEQ R0, #1
BXEQ LR

CMP R0, #4				//Check whether parameter is pb1
LSR R2, R2, #1			
ANDEQ R3, R2, #1		//get the BIT2 value
CMP R3, #1				//check whether the BIT2 is 
MOVEQ R0, #1
BXEQ LR

CMP R0, #8				//Check whether parameter is pb1
LSR R2, R2, #1			
ANDEQ R3, R2, #1		//get the BIT1 value
CMP R3, #1				//check whether the BIT3 is 1
MOVEQ R0, #1
BXEQ LR

MOV R0, #0
BX LR

read_PB_edgecap_ASM:
LDR R1, =PUSHBUTTON_EDGECAPTURE
LDR R0, [R1]
BX LR

PB_edgecap_is_pressed_ASM:
LDR R1, =PUSHBUTTON_EDGECAPTURE
LDR R2, [R1]			//value of edge register

CMP R0, #1				//Check whether parameter is pb0
ANDEQ R3, R2, #1		//get the 0 bit value
CMP R3, #1				//check whether the 0 bit is 1
MOVEQ R0, #1
BXEQ LR

CMP R0, #2				//Check whether parameter is pb1
LSR R2, R2, #1			
ANDEQ R3, R2, #1		//get the BIT1 value
CMP R3, #1				//check whether the BIT1 is 1
MOVEQ R0, #1
BXEQ LR

CMP R0, #4				//Check whether parameter is pb1
LSR R2, R2, #1			
ANDEQ R3, R2, #1		//get the BIT2 value
CMP R3, #1				//check whether the BIT2 is 
MOVEQ R0, #1
BXEQ LR

CMP R0, #8				//Check whether parameter is pb1
LSR R2, R2, #1			
ANDEQ R3, R2, #1		//get the BIT1 value
CMP R3, #1				//check whether the BIT3 is 1
MOVEQ R0, #1
BXEQ LR

MOV R0, #0

BX LR

PB_clear_edgecap_ASM:
//R0 PARAMETER FROM C
LDR R1, =PUSHBUTTON_EDGECAPTURE
MOV R5, #0
STR R5, [R1]
BX LR


enable_PB_INT_ASM:
//R0 from c parameter
/*
LDR R1, =PUSHBUTTON_INTERRUPTION
LDR R2, [R1]			//value of interrupt register
MOV R4, #3				//counter for loop
MOV R5, #0x0000000F		//mask
LOOP_ENABLE_INT:
SUBS R4, R4, #1			//update counter
BLT  STORE_INTERRUPT_ENABLE
AND R3, R0, #1			//R0: the parameter from C; this gets the last bit's value
CMP R3, #1				//Check the result of the last bit
ORREQ R2, R2, R5		//modify the value
MOV R6, #2
MUL R5, R5, R6			//update the mask for the next iteration
LSR R0, #1
B LOOP_ENABLE_INT
STORE_INTERRUPT_ENABLE:
STR R2, [R1]
BX LR
*/
LDR R1, =PUSHBUTTON_INTERRUPTION
STR R0, [R1]
BX LR


disable_PB_INT_ASM:
/*
LDR R1, =PUSHBUTTON_INTERRUPTION
LDR R2, [R1]			//value of interrupt register
MOV R4, #3				//counter for loop
MOV R5, #0xFFFFFFF0		//mask
LOOP_DISABLE_INT:
SUBS R4, R4, #1			//update counter
BLT  STORE_INTERRUPT_DISABLE
AND R3, R0, #1			//R0: the parameter from C; this gets the last bit's value
CMP R3, #1				//Check the result of the last bit
ANDEQ R2, R2, R5		//modify the value
MOV R6, #2
MOV R7, #15
MLA R5, R5, R6, R7		//update the mask for the next iteration
LSR R0, #1
B LOOP_DISABLE_INT
STORE_INTERRUPT_DISABLE:
STR R2, [R1]
BX LR
*/
LDR R1, =PUSHBUTTON_INTERRUPTION
LDR R2, [R1]
BIC R2, R2, R0
STR R2, [R1]
BX LR


.end
