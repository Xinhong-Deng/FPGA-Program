		.text
		.global read_PS2_data_ASM
		.equ PS2_Data, 0xFF200100

read_PS2_data_ASM:
PUSH {R1-R3}
LDR R1, =PS2_Data
LDR R2, [R1]
AND R3, R2, #0x8000
CMP R3, #0
MOVEQ R0, #0
POPEQ {R1-R3}
BXEQ LR
AND R3, R2, #0XFF
STRB R3, [R0]
MOV R0, #1
POP {R1-R3}
BX LR
.end
