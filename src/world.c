#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#include "world.h"

int world(int len, char*buff) {
	pthread_mutexattr_settype(NULL, 0);
	if((len > 0) && (buff != NULL)) {
		snprintf(buff, (size_t)len, "ceci est mon monde ...");
	}
	return 0;
}
