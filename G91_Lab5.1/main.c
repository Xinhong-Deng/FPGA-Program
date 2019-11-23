/**#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"

int amplitude = 10;
int t = 0;

float makeWave(int f, int t) {

	float index = (f * t) % 4800;
	int index1 = index;
	int index2 = index + 1;
	float decimal = index - index1;
	float sineValue = (1 - decimal) * sine[index1] + 
					decimal * sine[index2];

	return sineValue;
}

int main() {

	int flag[8];
	int signals[8];
	int i=0;
	for(; i<8; i++){
		signals[i]=0;
	}
	while(1) {

		char keyPressed;
		int keyValid = read_ps2_data_ASM(&keyPressed);
		if (keyValid) {
			switch (keyPressed) {
				case 0x1C:	//Key A
					signals[0] = makeWave(130.813, t);
					//printf("%d\n",signals[0]);
					break;
				case 0x1B:	//KEY S
					signals[1] = makeWave(146.832, t);
					break;
				case 0x23:	//KEY D
					signals[2] = makeWave(164.814, t);
					break;
				case 0x2B:	//KEY F
					signals[3] = makeWave(174.614, t);
					break;
				case 0x3B:	//KEY J
					signals[4] = makeWave(195.998, t);
					break;
				case 0x42:	//KEY K
					signals[5] = makeWave(220.000, t);
					break;
				case 0x4B:	//KEY L
					signals[6] = makeWave(246.942, t);
					break;
				case 0x4C:	//KEY ;
					signals[7] = makeWave(261.626, t);
					break;
				case 0x6B:	//KEY Z, for volume up
					amplitude ++;
					break;
				case 0x22:	//KEY X. for volume down
					if (amplitude > 0)
						amplitude --;
					break;

			}

			int sum = 0;
			int i = 0;
			for (; i < 8; i++) {
				sum += signals[i];

			}
printf("%d\n",sum);
			if (audio_write_data_ASM(sum, sum)) {
				t ++;
			}

			if (t == 47999) {
				t = 0;
			}
		}
	}

	return 0;
}
**/



#include <stdlib.h>

#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"

float frequencies[] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};

double makeWave(float f, int t) {
	int index = (((int)f) * t)%48000;
	double signal = sine[index];

	return signal;
}


int main() {
	
	int_setup(1, (int []){199});
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0; 
	hps_tim.timeout = 20; 
	hps_tim.LD_en = 1; 
	hps_tim.INT_en = 1; 
	hps_tim.enable = 1; 

	HPS_TIM_config_ASM(&hps_tim);

	int breakchar = 0;

	int t = 0;


	char value;
	int amplitude = 1;
	double signalSum = 0.0;
	int signals[8];

	while(1) {

				if (read_ps2_data_ASM(&value)) {
					switch (value){
						case 0x1C://Key A
							if(breakchar == 1){
								signals[0] = 0;
								breakchar= 0;
							} else{							
								signals[0] = 1;
							}
							break;
						case 0x1B://Key S
							if(breakchar == 1){								
								signals[1] = 0;
								breakchar = 0;
							} else{							
								signals[1] = 1;
							}
							break;
						case 0x23://Key D
							if(breakchar== 1){
								signals[2] = 0;
								breakchar = 0;
							} else{
								signals[2] = 1;
							}
							break;
						case 0x2B://Key F
							if(breakchar == 1){
								signals[3] = 0;
								breakchar = 0;
							} else{
								signals[3] = 1;
							}
							break;
			
						case 0x3B://Key J
							if(breakchar == 1){
								signals[4] = 0;
								breakchar = 0;
							} else{
								signals[4] = 1;
							}
							break;
				
						case 0x42://Key K
							if(breakchar == 1){
								signals[5] = 0;
								breakchar = 0;
							} else{
								signals[5] = 1;
							}
							break;
			
						case 0x4B://Key L
							if(breakchar == 1){
								signals[6] = 0;
								breakchar = 0;
							} else{
								signals[6] = 1;
							}
							break;
				
						case 0x4C://Key ;
							if(breakchar== 1){
								signals[7] = 0;
								breakchar = 0;
							}else{
								signals[7] = 1;
							}
							break;
						
						case 0x32://KEY B FOR VOLUME UP
							if(breakchar == 1){
								amplitude=amplitude++;
								breakchar = 0;
							}
							break;
						
						case 0x22://KEY C FOR VOLUME DOWN
							if(breakchar == 1){
								if(amplitude>0)
								amplitude=amplitude--;
								breakchar = 0;
							}
							break;
						case 0xF0: //the break code is the same for all keys
							breakchar = 1;
							break;
						default:
							breakchar = 0;
					}
				}
			
			
			int i;
			for(i = 0; i < 8; i++){
		
				if(signals[i] == 1){
					signalSum += amplitude*makeWave(frequencies[i], t);
					}
			}
			
			if(hps_tim0_int_flag == 1) {
				hps_tim0_int_flag = 0;
				audio_write_data_ASM(signalSum, signalSum);
				t++;
			}

			signalSum = 0;

			if(t==47999){
				t=0;
			}
		
	}


	return 0;
}
