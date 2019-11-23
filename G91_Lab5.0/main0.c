
#include "./drivers/inc/audio.h"

int main() {
	int tmp = 0x00FFFFFF;
	int t=0;
	while (1) {
		
		if (audio_write_data_ASM(tmp))
			t ++;
		

		if (t <240) {
			tmp = 0x00FFFFFF;
		}else {
			tmp = 0x0000000;
		}
		
		if (t > 480) {
			t = 0;
		}

	}	
}


