#include <stdio.h>
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/address_map_arm.h"
#include "./drivers/inc/int_setup.h"

int main(){

HPS_TIM_config_t hpstim;
hpstim.tim = TIM0;
hpstim.timeout = 10000; 
hpstim.LD_en = 1;
hpstim.INT_en = 0;
hpstim.enable = 1;
HPS_TIM_config_ASM(&hpstim);

int timer_start=0;
int ms=0;
int second=0;
int minute = 0;
char mmsDis = '0';
char msDis = '0';
char secondDis = '0';
char tensDis = '0';
char minuteDis = '0';
char tenmDis = '0';

while(1){
if (HPS_TIM_read_INT_ASM(TIM0) && timer_start) {
     HPS_TIM_clear_INT_ASM(TIM0);
     ms=ms+10;
     if(ms>=1000){
      ms=0;
      second++;
      if(second>=60){
        second=0;
        minute++;
        if(minute>=60){
        minute=0;
        }
      }
     }
     mmsDis=ms%100/10+48;
     msDis=ms/100+48;
     secondDis=second%10+48;
     tensDis=second/10 +48;
     minuteDis=minute%10+48;
     tenmDis=minute/10+48;
     
      	HEX_write_ASM(HEX0, mmsDis);
		HEX_write_ASM(HEX1, msDis);
		HEX_write_ASM(HEX2, secondDis);
		HEX_write_ASM(HEX3, tensDis);
		HEX_write_ASM(HEX4, minuteDis);
		HEX_write_ASM(HEX5, tenmDis);
}
  
			int pb =read_PB_data_ASM();
			if (pb & 1) { //Start timer
				timer_start = 1;
			} else if ((pb & 2) && (timer_start)) { //Stop timer
				timer_start = 0;
			} else if (pb & 4) { 
				ms = 0;
				second = 0;
				minute = 0;
				timer_start = 0; 
				mmsDis = '0';
				msDis = '0';
				secondDis = '0';
				tensDis = '0';
				minuteDis = '0';
				tenmDis = '0';
				}
				
			HEX_write_ASM(HEX0, mmsDis);
			HEX_write_ASM(HEX1, msDis);
			HEX_write_ASM(HEX2, secondDis);
			HEX_write_ASM(HEX3, tensDis);
			HEX_write_ASM(HEX4, minuteDis);
			HEX_write_ASM(HEX5, tenmDis);
			}
		

	return 0;
}
