CC ?= gcc
CFLAGS ?= -fPIC -Wall -Wextra -O2
LDFLAGS ?=
EXEC=hello2
VERS_MAJ=0
VERS_MIN=0
VERS_REV=1
LIBNAME=libmyworld.so
TARGET_LIB=$(LIBNAME).$(VERS_MAJ).$(VERS_MIN).$(VERS_REV)
SRC_EXE=src/hello.c src/world.h
OBJ_EXE=$(SRC_EXE:.c=.o)
LIB_EXE= -L$(PWD) -lmyworld
SRC_LIB=src/world.c src/world.h
OBJ_LIB=$(SRC_LIB:.c=.o)
PREFIX ?= /usr/local

all: $(TARGET_LIB) $(EXEC)

$(EXEC): $(TARGET_LIB) $(OBJ_EXE)
	@$(CC) -o $@ $^ $(LIB_EXE) $(LDFLAGS)

$(TARGET_LIB): $(OBJ_LIB)
	@$(CC) -o $@ $^ -shared $(LDFLAGS)
	@ln -s $(TARGET_LIB) $(LIBNAME).$(VERS_MAJ).$(VERS_MIN)
	@ln -s $(LIBNAME).$(VERS_MAJ).$(VERS_MIN) $(LIBNAME).$(VERS_MAJ)
	@ln -s $(LIBNAME).$(VERS_MAJ) $(LIBNAME)

%.o: %.c
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -rf $(LIBNAME)* $(EXEC) src/*.o

mrproper: clean
	@rm -f $(EXEC) $(TARGET_LIB)

install: $(TARGET_LIB) $(EXEC)
	@install -d $(DESTDIR)$(PREFIX)/bin/
	@install -m 755 $(EXEC) $(DESTDIR)$(PREFIX)/bin/
	@install -d $(DESTDIR)$(PREFIX)/lib/
	@install -m 644 $(TARGET_LIB) $(DESTDIR)$(PREFIX)/lib/
	@ln -s $(DESTDIR)$(PREFIX)/lib/$(TARGET_LIB) $(DESTDIR)$(PREFIX)/lib/$(LIBNAME).$(VERS_MAJ).$(VERS_MIN)
	@ln -s $(DESTDIR)$(PREFIX)/lib/$(LIBNAME).$(VERS_MAJ).$(VERS_MIN) $(DESTDIR)$(PREFIX)/lib/$(LIBNAME).$(VERS_MAJ)
	@ln -s $(DESTDIR)$(PREFIX)/lib/$(LIBNAME).$(VERS_MAJ) $(DESTDIR)$(PREFIX)/lib/$(LIBNAME)
