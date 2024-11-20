.include "linux64.asm"

.section .data
hello:
    .ascii "hello world my niggas how are you doing this fine evening\n\0"



input_buffer:
    .space 128


.section .text
.global _start

_start:
    #lea hello(%rip), %rdi  # Load the address of the string into %rdi


    #movq $STDIN_DESC,%rdi
    #lea input_buffer(%rip),%rsi
    #movq $128,%rdx
    #movq $SYS_READ,%rax
    #syscall



    leaq input_buffer(%rip),%rdi
    push %rdi 
    push $128 
    call input

    add $16,%rsp



    sub $8, %rsp           # Allocate stack space
    leaq input_buffer(%rip),%rdi
    mov %rdi, (%rsp)       # Store the address on the stack
    call print            
    add $8,%rsp
 
    mov $SYS_EXIT, %rax          
    xor %rdi, %rdi         
    syscall               

