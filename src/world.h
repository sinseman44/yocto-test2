#ifndef WORLD_H
#define WORLD_H

#include <dlfcn.h>

#define world(a, b) do { dlclose(b); __world(a, b); } while(0)

int __world(int len, char*buff);


#endif /* WORLD_H */
