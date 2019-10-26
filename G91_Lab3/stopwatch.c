
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
hpstim.timeout = 1000000; 
hpstim.LD_en = 1;
hpstim.INT_en = 0;
hpstim.enable = 1;
HPS_TIM_config_ASM(&hpstim);

int start=0;
int ms=0;
int second=0;
int hour = 0;
while(1){
if (HPS_TIM_read_ASM(TIM0) && timer_start) {
     HPS_TIM_clear_INT_ASM(TIM0);
     ms=ms+10;
     if(ms==1000){
      ms=0;
      second++;
      if(second=60){
        second=0;
        minute++;
        if(minute=60){
        minute=0;
        }
      }
     }
     int mmsDis=ms%100+48;
     int msDis=ms/100+48;
     int secondDis=second%10+48;
     int tensDis=second/10 +48;
     int minuteDis=minute%10+48;
     int tenmDis=minute/10+48;
     
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
				ms_count = 0;
				sec_count = 0;
				min_count = 0;
				timer_start = 0; 
				}
				
				HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 48);
			}
		}

	return 0;
}
}
