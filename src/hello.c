#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "world.h"

int main(int argc, char** argv) {
	int ret = 0;
	char str[64];
	memset(str, 0, sizeof(str));
	ret = world(sizeof(str), str);
	printf("Hello World => %s\n", str);
	return ret;
}
