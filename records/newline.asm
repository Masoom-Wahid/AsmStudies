.include "linux.asm"
.global newline
.type newline, @function


new_line:
    .ascii "\n"


.section .text
.equ ST_FILEDES, 8



newline:
    pushl %ebp
    movl %esp,%ebp

    movl $SYS_WRITE,%eax
    movl ST_FILEDES(%ebp),%ebx
    movl $new_line,%ecx
    movl $1,%edx
    int $LINUX_SYSCALL
    movl %ebp,%esp
    popl %ebp
    ret
