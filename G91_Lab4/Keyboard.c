#include <stdio.h>
#include "inc/VGA.h"
#include "inc/ps2_keyboard.h"
int main() {
	VGA_clear_charbuff_ASM();
	int x=0, y=0, v=0;
	char c;
	char * data = &c;
	while(1){
	v = read_PS2_data_ASM(data);
	if(v == 1){
		VGA_write_byte_ASM(x, y, *data);
		x += 3;
	}
	if(x >= 79){
	x=0;
	y++;
	}
	if(y>=59){
	y=0;
	}
	}
	return 0;
}
