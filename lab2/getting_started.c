#include "address_map_arm.h"

int main(int argc, const char* argv[])
{
	int a[5]={1,20,3,4,5};
	int min_val = a[0];
	int i = 0;
	for (; i < 5; i++) {
		if (min_val > a[i]){
			min_val = a[i];
		}
	}
	return min_val;
}
