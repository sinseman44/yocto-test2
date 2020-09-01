CC ?= gcc
CFLAGS ?= -fPIC -Wall -Wextra -O2
LDFLAGS ?= -shared
EXEC=hello2
TARGET_LIB=libmyworld.so
SRC_EXE=src/hello.c src/world.h
OBJ_EXE=$(SRC_EXE:.c=.o)
LIB_EXE= -L$(PWD) -lmyworld
SRC_LIB=src/world.c src/world.h
OBJ_LIB=$(SRC_LIB:.c=.o)
PREFIX ?= /usr/local

all: $(TARGET_LIB) $(EXEC)

$(EXEC): $(OBJ_EXE)
	@$(CC) -o $@ $^ $(LIB_EXE)

$(TARGET_LIB): $(OBJ_LIB)
	@$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -rf $(TARGET_LIB) $(EXEC) src/*.o

mrproper: clean
	@rm -f $(EXEC) $(TARGET_LIB)

install: $(TARGET_LIB) $(EXEC)
	@install -d $(DESTDIR)$(PREFIX)/bin/
	@install -m 755 $(EXEC) $(DESTDIR)$(PREFIX)/bin/
	@install -d $(DESTDIR)$(PREFIX)/lib/
	@install -m 644 $(TARGET_LIB) $(DESTDIR)$(PREFIX)/lib/
