# Makefile for assembling and linking 32-bit assembly programs

# Compiler and linker
AS = as --32
LD = ld -m elf_i386

# Targets
all: program

program: read.o
	$(LD) manager.o read.o -o program	

manager.o: manager.asm
	$(AS) manager.asm -o manager.o

read.o: read.asm
	$(AS) read.asm -o read.o

clean:
	rm -f *.o program

