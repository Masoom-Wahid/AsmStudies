.section .data

.section .text

.global _start

# Support for a number raised to 0

_start:
    pushl $4         # Push exponent
    call fact
    movl %eax,%ebx
    movl $1,%eax
    int $0x80


.type fact, @function

fact:
    pushl %ebp        # Save base pointer
    movl %esp, %ebp   # Set base pointer

    
    movl 8(%ebp), %eax  # load the param
        
    cmp $1,%eax
    je fact_done
    
    decl %eax
    pushl %eax

    call fact

    movl 8(%ebp),%ebx

    imull %ebx,%eax

fact_done:
    movl %ebp,%esp
    popl %ebp
    ret
