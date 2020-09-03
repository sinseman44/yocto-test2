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
#LIB_EXE= -L$(PWD) -lmyworld
SRC_LIB=src/world.c src/world.h
OBJ_LIB=$(SRC_LIB:.c=.o)
PREFIX ?= /usr/local

.PHONY: all mrproper clean install

all: $(TARGET_LIB) $(EXEC) libworld.pc

libworld.pc:
	@echo "Generating pc file"
	@sed -e "s|@PREFIX@|$(PREFIX)|g" -e "s|@VERSION@|$(VERS_MAJ).$(VERS_MIN).$(VERS_REV)|g" libworld.pc.in > libworld.pc

$(EXEC): $(TARGET_LIB) $(OBJ_EXE)
	$(CC) -o $@ $^ -ldl $(TARGET_LIB) $(LDFLAGS)

$(TARGET_LIB): $(OBJ_LIB)
	$(CC) -o $@ $^ -shared $(LDFLAGS) -Wl,-soname,$(LIBNAME).$(VERS_MAJ)

%.o: %.c
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -rf $(TARGET_LIB) $(EXEC) src/*.o libworld.pc

mrproper: clean
	@rm -f $(EXEC) $(TARGET_LIB)

install: $(TARGET_LIB) $(EXEC)
	@install -d $(DESTDIR)$(PREFIX)/bin/
	@install -m 755 $(EXEC) $(DESTDIR)$(PREFIX)/bin/
	@install -d $(DESTDIR)$(PREFIX)/lib/
	@install -m 644 $(TARGET_LIB) $(DESTDIR)$(PREFIX)/lib/
	@ln -sf $(TARGET_LIB) $(DESTDIR)$(PREFIX)/lib/$(LIBNAME).$(VERS_MAJ)
	@ln -sf $(LIBNAME).$(VERS_MAJ) $(DESTDIR)$(PREFIX)/lib/$(LIBNAME)
	@install -Dm 644 src/world.h $(DESTDIR)$(PREFIX)/include/libworld/world.h
	@install -Dm 644 libworld.pc ${DESTDIR}/$(PREFIX)/lib/pkgconfig/libworld.pc
