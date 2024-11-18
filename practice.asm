.section .data

.section .text

.global _start

# Support for a number raised to 0

_start:
    pushl $2         # Push exponent
    pushl $5          # Push base
    call power        # Call power function
    addl $8, %esp     # Clean up stack after call
    movl %eax, %ebx   # Move result to ebx for exit
    movl $1, %eax     # syscall: exit
    int $0x80         # Make syscall

.type power, @function

power:
    pushl %ebp        # Save base pointer
    movl %esp, %ebp   # Set base pointer
    subl $4, %esp     # Allocate space for result

    movl 8(%ebp), %ebx  # Load base (adjust if needed based on calling convention)
    movl 12(%ebp), %ecx # Load exponent

    cmp $0,%ecx
    je value_done

    movl %ebx, -4(%ebp) # Initialize result to base value

power_loop_start:
    cmpl $1, %ecx     # Compare exponent with 1
    jle end_power     # If less or equal to 1, jump to end
    movl -4(%ebp), %eax  # Move result into eax
    imull %ebx, %eax     # Multiply result by base
    movl %eax, -4(%ebp)  # Store result back

    decl %ecx            # Decrement exponent
    jmp power_loop_start # Repeat loop

value_done:
    movl $1, %ebx        # Set result to 1 if exponent is 0
    movl $1,%eax
    int $0x80


end_power:
    movl -4(%ebp), %eax # Move result to eax
    movl %ebp, %esp     # Clean up stack frame
    popl %ebp           # Restore base pointer
    ret                 # Return from function

