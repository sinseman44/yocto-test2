#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#include "world.h"

int __world(int len, char*buff) {
	if((len > 0) && (buff != NULL)) {
		snprintf(buff, (size_t)len, "ceci est mon monde ...");
	}
	return 0;
}
