# Makefile for assembling and linking 32-bit Assembly files using as and ld

# List of source files
# count_chars.asm
#SRC :=  linux.asm def.asm read.asm write.asm seed.asm

#SRC :=  linux.asm def.asm read.asm newline.asm count_chars.asm write.asm read_seed.asm


SRC :=  linux.asm def.asm read.asm newline.asm count_chars.asm write.asm edit_seed.asm

OBJ := $(SRC:.asm=.o)
EXEC := program
AS := as
AS_FLAGS := --32
LD := ld
LD_FLAGS := -m elf_i386

# Default target
all: $(EXEC)

# Rule to link object files into the final executable
$(EXEC): $(OBJ)
	$(LD) $(LD_FLAGS) $(OBJ) -o $(EXEC)
	@echo "Compiled successfully: $(EXEC)"

# Rule to assemble .asm files into .o object files
%.o: %.asm
	$(AS) $(AS_FLAGS) $< -o $@

# Clean up object files and the executable
clean:
	rm -f $(OBJ) $(EXEC)

# Optional clean-all target that removes all generated files
clean-all: clean
	rm -f $(EXEC)

# Phony targets
.PHONY: all clean clean-all

