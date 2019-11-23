.text
.equ fifo, 0xFF203044
.equ leftdata, 0xFF203048
.equ rightdata, 0xFF20304C

.global audio_write_data_ASM

audio_write_data_ASM:
PUSH {R1,R6}
LDR R1, =fifo
LDR R2, =leftdata
LDR R3, =rightdata
LDRB R4, [R1,#2]
LDRB R5, [R1,#3]
CMP R4, #0
POPEQ {R1,R6}
MOVEQ R0, #0
BXEQ LR
CMP R5, #0
POPEQ {R1,R6}
MOVEQ R0, #0
BXEQ LR
STR R0, [R2]
STR R0, [R3]
POP {R1,R6}
MOV R0, #1
BX LR
.end
