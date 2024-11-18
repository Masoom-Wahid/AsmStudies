.section .data
    b:
        .long 49

.section .text

.global _start

_start:
    movl $0,%edi
    pushl $1
    call square
    movl %eax,%ebx
    movl $1,%eax
    int $0x80

.type square,@function


square:
    pushl %ebp
    movl %esp,%ebp

    movl 8(%ebp),%eax
    imull %eax,%eax
    cmpl b(,%edi,4),%eax
    je found_answer
    jg not_found_answer

    movl 8(%ebp),%eax
    incl %eax
    pushl %eax

    call square

    addl $4,%esp
    popl %ebp
    ret


found_answer:
    movl 8(%ebp),%eax
    popl %ebp
    ret

not_found_answer:
    movl $0,%eax
    popl %ebp
    ret





