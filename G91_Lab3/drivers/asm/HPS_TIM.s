.text
.equ TIM0, 0xFFC08000
.equ TIM1, 0xFFC09000
.equ TIM2, 0xFFD00000
.equ TIM3, 0xFFC01000

.global HPS_TIM_config_ASM, HPS_TIM_read_INT_ASM, HPS_TIM_clear_INT_ASM
HPS_TIM_config_ASM:
//R0: address of the first component(TIM) in the struct
PUSH {LR}
//PUSH {R1-R8}
LDR R1,[R0]
AND R2, R1, #0x00000001				//get the bit0
CMP R2, #0x00000001					//check whether bit0 is
LDREQ R3, =TIM0
MOVEQ R8, #100
BLEQ SET
AND R2, R1, #0x00000002				//get the bit1
CMP R2, #0x00000002					//check whether bit1 is 1
LDREQ R3, =TIM1
MOVEQ R8, #100
BLEQ SET
AND R2, R1, #0x00000004				//get the bit 2
CMP R2, #0x00000004					//check whether bit2 is 1
LDREQ R3, =TIM2
MOVEQ R8, #25
BLEQ SET
AND R2, R1, #0x00000008				//get the bit 3
CMP R2, #0x00000008					//check whether bit3 is 1
LDREQ R3, =TIM3
MOVEQ R8, #25
BLEQ SET
//POP {R1-R8}
POP {LR}
BX LR

SET:
ADD R4, R3, #8						//R4 IS THE ADDRESS OF THE CONTROL REGISTER
LDR R5, [R4]						//R5 STORES THE CONTROL PART OF THE TIMER

LDR R7, [R0, #8]					//READ THE LOAD ENABLE PARAMETER
CMP R7, #1							//CHECK WHETHER ENABLE IS 1
ORREQ R5, R5, #0x00000002			//UPDATE THE bitM WITH 1
ANDEQ R5, R5, #0xFFFFFFFE			//SET THE E TO 0, SO THE LOAD VALUE CAN BE WRITE TO THE LOAD REGISTER
STREQ R5, [R0, #8] 
LDREQ R6, [R0, #4] 					//R6 STORES THE TIME OUT PARAMETER
MULEQ R6, R6, R8					//CALCUALTE THE LOAD VALUE CONSIDERING THE CLOCK FREQUENCY
STREQ R6, [R3] 						//UPDATE THE LOAD REGISTER
ANDNE R5, R5, #0xFFFFFFFD			//UPDATE THE bitM WITH 0

LDR R7, [R0, #16]					//READ THE ENABLE PARAMETER
CMP R7, #0x00000001							
ORREQ R5, R5, #0x00000001			//UPDATE THE bitE BASED ON THE PARAMETER
ANDNE R5, R5, #0xFFFFFFFE

//SET THE I
LDR R7, [R0, #12]					//READ THE INT_ENABLE PARAMETER
CMP R7, #1
ORREQ R5, R5, #0x00000004			//UPDATE THE bitI based on the parameter
ANDNE R5, R5, #0xFFFFFFFB

STR R5, [R3, #8]
BX LR

HPS_TIM_read_INT_ASM:
//PUSH {R1-R4}
MOV R1, R0							//LOAD THE PARAMETER VALUE (first component: TIM)
AND R2, R1, #0x00000001				//get the bit0
CMP R2, #0x00000001
LDREQ R3,=TIM0
BEQ READS
AND R2, R1, #0x00000002				//get the bit1
CMP R2, #0x00000002	
LDREQ R3,=TIM1
BEQ READS
AND R2, R1, #0x00000004				//get the bit2
CMP R2, #0x00000004
LDREQ R3,=TIM2
BEQ READS
AND R2, R1, #0x00000008				//get the bit3
CMP R2, #0x00000008
LDREQ R3,=TIM3
BEQ READS
READS:
LDR R4, [R3, #16]					//R4 is the interrupt signal value
AND R0, R4, #1
//POP {R1-R4}
BX LR


HPS_TIM_clear_INT_ASM:
PUSH {LR}
//PUSH {R1-R10}
MOV R1, R0
AND R2, R1, #0x00000001				//get the bit0
CMP R2, #0x00000001					//check whether bit0 is
LDREQ R3, =TIM0
BLEQ SET_F_S
AND R2, R1, #0x00000002				//get the bit1
CMP R2, #0x00000002					//check whether bit1 is 1
LDREQ R3, =TIM1
BLEQ SET_F_S
AND R2, R1, #0x00000004				//get the bit 2
CMP R2, #0x00000004					//check whether bit2 is 1
LDREQ R3, =TIM2
BLEQ SET_F_S
AND R2, R1, #0x00000008				//get the bit 3
CMP R2, #0x00000008					//check whether bit3 is 1
LDREQ R3, =TIM3
BLEQ SET_F_S
//POP {R1-R10}
POP {LR}
BX LR
SET_F_S:
LDR R4, [R3, #12]
BX LR

.end





















