.type strlen, @function
.global strlen 


.equ ST_STRING_START_ADDRESS, 16

# ecx = curr count
# al = curr char
# edx = pointer to curr char


strlen:
    push %rbp
    mov %rsp, %rbp

    mov $0, %rcx

    mov ST_STRING_START_ADDRESS(%rbp),%rdx


count_loop_begin:
    movb (%rdx),%al

    cmpb $0,%al
    je count_loop_end
    inc %rcx
    inc %rdx
    jmp count_loop_begin

count_loop_end:
    mov %rcx,%rax
    mov %rbp,%rsp
    pop %rbp
    ret
