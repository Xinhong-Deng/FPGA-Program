#include <stdio.h>
#include "inc/VGA.h"

void test_char() {
	int x,y;
	char c = 0;

	for (y = 0; y <= 59; y++) {
		for (x = 0; x <= 79; x++) {
			VGA_write_char_ASM(x, y, c++);
		}
	}
}

void test_byte() {
	int x, y;
	char c = 0;

	for (y = 0; y <= 59; y++) {
		for (x = 0; x <= 79; x+=3) {
			VGA_write_byte_ASM(x, y, c++);
		}
	}
}

void test_pixel() {
	int x, y;
	unsigned short colour = 0;

	for (y = 0; y <= 239; y++) {
		for (x = 0; x <= 319; x++) {
			VGA_draw_point_ASM(x, y, colour++);
		}
	}
}

int main(void)
{
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();

	while (1) {
		int pb = read_PB_data_ASM();
		int slider = read_slider_switches_ASM();
		if (pb == 1) {
			if (slider != 0) 
				test_byte();
			else
				test_char();
		}

		if (pb == 2) {
			test_pixel();
		}

		if (pb == 4) {
			VGA_clear_charbuff_ASM();
		}

		if (pb == 8) {
			VGA_clear_pixelbuff_ASM();
		}
	}
	

}
