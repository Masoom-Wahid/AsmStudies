# Makefile for assembling and linking 32-bit Assembly files using as and ld

SRC :=  linux64.asm input.asm print.asm strlen.asm main.asm 

OBJ := $(SRC:.asm=.o)
EXEC := program
AS := as
LD := ld

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


