	.text
	
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR

	.global hps_tim0_int_flag
	.global pb_int_flag

hps_tim0_int_flag:
	.word 0x0

pb_int_flag:
	.word 0x0

A9_PRIV_TIM_ISR:
	BX LR
	
HPS_GPIO1_ISR:
	BX LR
	
HPS_TIM0_ISR:						//when the interrupt is enabled, the status bit should be changed to one 
	push {LR}				
	
	MOV R0, #0x1
	BL HPS_TIM_clear_INT_ASM		//clear Tim0

	LDR R0, =hps_tim0_int_flag 		//load the interrupt flag
	MOV R1, #1						//set the flag to 1
	STR R1, [R0]

	POP	{LR}
	BX LR
	
HPS_TIM1_ISR:
	BX LR
	
HPS_TIM2_ISR:
	BX LR
	
HPS_TIM3_ISR:
	BX LR
	
FPGA_INTERVAL_TIM_ISR:
	BX LR
	
FPGA_PB_KEYS_ISR:					//generate interrupt
	PUSH {LR}
	BL read_PB_edgecap_ASM			 //read pushbutton edge capture register to see which button is pressed
	
	LDR R1, =pb_int_flag

	STR R0, [R1]					//set the flag
	
	BL PB_clear_edgecap_ASM			//clear the edgecapture register
	POP {LR}
	BX LR
	
FPGA_Audio_ISR:
	BX LR
	
FPGA_PS2_ISR:
	BX LR
	
FPGA_JTAG_ISR:
	BX LR
	
FPGA_IrDA_ISR:
	BX LR
	
FPGA_JP1_ISR:
	BX LR
	
FPGA_JP2_ISR:
	BX LR
	
FPGA_PS2_DUAL_ISR:
	BX LR
	
	.end
