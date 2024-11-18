.section .data


.section .text

.global _start



_start:
    pushl $4
    call fact
    movl %eax,%ebx
    movl $1,%eax
    int $0x80


.type fact,@function


fact:
    pushl %ebp
    movl %esp,%ebp

    movl 8(%ebp),%eax

    cmpl $1,%eax
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


