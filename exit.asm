.section .data

.section .text

.global _start


_start:
    movl $1, %eax
    movl $10, %ebx # register ebx , 0-255 . status os
    int $0x80
