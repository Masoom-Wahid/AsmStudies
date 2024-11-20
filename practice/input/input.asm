.include "linux64.asm"

.type input, @function
.global input



.equ ST_INPUT_BUFFER,24
.equ ST_INPUT_BUFFER_LEN,16

input:
    push %rbp
    mov %rsp,%rbp

    movq $STDIN_DESC,%rdi
    mov ST_INPUT_BUFFER(%rbp),%rsi
    mov ST_INPUT_BUFFER_LEN(%rbp),%rdx
    movq $SYS_READ,%rax
    syscall

    mov %rbp,%rsp
    pop %rbp
    ret
