	.text
	.global _start
_start:
	MOV R0, #2;
	PUSH {R0};
	MOV R0, #3;
	PUSH {R0};
	MOV R0, #4;
	PUSH {R0};
	POP {R1-R3};
	
END:
	B END;