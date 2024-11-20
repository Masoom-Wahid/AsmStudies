.include "linux64.asm"

.equ ST_DATA,16

.type print, @function
.global print

print:
    push %rbp
    mov %rsp,%rbp
    
    sub $8,%rsp
    push ST_DATA(%rbp)
    call strlen # Call strlen
    add $8,%rsp
    mov ST_DATA(%rbp), %rsi         # Load the address of the string into %rsi
    mov %rax, %rdx         # The length (returned in %rax) is moved to %rdx
    mov $STDOUT_DESC, %rdi      
    mov $1, %rax           # System call number (1 = write)
    syscall                # Perform the write


    mov %rbp,%rsp
    pop %rbp
    ret
