.section .data

first_string:
    .ascii "Hello %s %s,this is you first program written in %s for the %d time\n\0"

name:
    .ascii "Wow\0"

last_name:
    .ascii "Bow\0"

lang:
    .ascii "asm\0"

try:
    .long 3

.section .text

.global _start

_start:
    # Parameters are passed in these registers for x86_64:
    # rdi, rsi, rdx, rcx, r8, r9
    
    movq $first_string, %rdi    # First parameter
    movq $name, %rsi            # Second parameter
    movq $last_name, %rdx       # Third parameter
    movq $lang, %rcx            # Fourth parameter
    movl try, %r8d              # Fifth parameter

    # Align stack to 16 bytes before call
    pushq %rbp
    movq %rsp, %rbp
    
    # Call printf
    call printf
    # Exit
    movq $60, %rax    # syscall number for exit
    movq $0, %rdi     # exit status
    syscall
