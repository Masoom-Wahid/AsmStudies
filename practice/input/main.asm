.include "linux64.asm"

.section .data
hello:
    .ascii "Hello and welcome to the guessing game\n\0"



input_msg:
    .ascii "Please Enter a number from 0-255: \0"

error_msg:
    .ascii "Sorry Wrong number\n\0"

correct_msg:
    .ascii "Yay, Correct Number\n\0"

NOT_SECRET:
    .quad 256

input_buffer:
    .space 128


.section .text
.global _start

_start:
    sub $8,%rsp
    leaq hello(%rip), %rdi  # Load the address of the string into %rdi
    mov %rdi,(%rsp)
    call print
    add $8,%rsp


    leaq input_buffer(%rip),%rdi # keeps the input buffer
    leaq input_msg(%rip),%rcx # keep the greeting


    
    #sub $8, %rsp           # Allocate stack space
    #leaq input_buffer(%rip),%rdi
    #mov %rdi, (%rsp)       # Store the address on the stack

    #call print            
    #add $8,%rsp
    


guess_loop_start:
    sub $8,%rsp
    leaq input_msg(%rip),%rcx # keep the greeting
    mov %rcx,(%rsp)
    call print
    add $8,%rsp
    


    leaq input_buffer(%rip),%rdi
    push %rdi 
    push $128 
    call input
    add $16,%rsp

    sub $8,%rsp
    leaq input_buffer(%rip),%rdi
    mov %rdi,(%rsp)
    call atoi
    add $8,%rsp

    cmp $255,%rax
    jne incorrect_answer_tag

    sub $8,%rsp
    leaq correct_msg(%rip), %rdi  
    mov %rdi,(%rsp)
    call print
    add $8,%rsp

    mov $0,%rdi
    mov $SYS_EXIT, %rax          
    syscall 

incorrect_answer_tag:
    sub $8,%rsp
    leaq error_msg(%rip), %rdi  
    mov %rdi,(%rsp)
    call print
    add $8,%rsp

    jmp guess_loop_start


