#include <stdio.h>
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"

int main(){
	while(1){
		int switchStatus = read_slider_switches_ASM();
		write_LEDs_ASM(switchStatus);		//MAP THE SWITCH TO THE LED
		
		if (switchStatus == 0x200)
		{
			HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
		}
		else 
		{
			//HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3);
			char hexValue;
			switch (switchStatus) 
			{
				case 0:
					hexValue = '0';
					break;
				case 1:
					hexValue = '1';
					break;
				case 2:
					hexValue = '2';
					break;
				case 3:
					hexValue = '3';
					break;
				case 4:
					hexValue = '4';
					break;
				case 5:
					hexValue = '5';
					break;
				case 6:
					hexValue = '6';
					break;
				case 7:
					hexValue = '7';
					break;
				case 8:
					hexValue = '8';
					break;
				case 9:
					hexValue = '9';
					break;
				case 10:
					hexValue = 'A';
					break;
				case 11:
					hexValue = 'B';
					break;
				case 12:
					hexValue = 'C';
					break;
				case 13:
					hexValue = 'D';
					break;
				case 14:
					hexValue = 'E';
					break;
				case 15:
					hexValue = 'F';
					break;
				//default:
				//	hexValue = '';
			}

			HEX_flood_ASM(HEX4 | HEX5);
			int pushButtonStatus = read_PB_data_ASM();
			HEX_write_ASM(pushButtonStatus, hexValue);
		}
	}
	return 0;
}
