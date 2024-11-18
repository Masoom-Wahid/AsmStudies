.include "linux.asm"
.include "def.asm"

.section .data
file_name:
    .ascii "output.dat\0"


introduction:
    .ascii "hello and welcome to ready you data\n\0"


.section .bss
.lcomm record_buffer,RECORD_SIZE

.section .text

.global _start

_start:
    .equ ST_INPUT_DESC, -4
    .equ ST_OUTPUT_DESC, -8

    movl %esp,%ebp
    subl $8,%esp

    movl $SYS_OPEN,%eax
    movl $file_name,%ebx
    movl $0,%ecx
    movl $0666,%edx
    int $LINUX_SYSCALL

    movl %eax,ST_INPUT_DESC(%ebp)

    movl $STDOUT,ST_OUTPUT_DESC(%ebp)

    pushl $introduction
    call count_chars
    addl $4, %esp
    movl %eax,%edx
    movl $SYS_WRITE,%eax
    movl ST_OUTPUT_DESC(%ebp),%ebx
    movl $introduction,%ecx
    int $LINUX_SYSCALL




read_record_loop:
    pushl ST_INPUT_DESC(%ebp)
    pushl $record_buffer
    call read_record
    addl $8,%esp

    cmpl $RECORD_SIZE, %eax
    jne finished_reading

    pushl $RECORD_AGE + record_buffer
    call count_chars

    addl $4,%esp

    movl %eax,%edx
    movl ST_OUTPUT_DESC(%ebp),%ebx
    movl $SYS_WRITE, %eax
    movl $RECORD_AGE + record_buffer, %ecx
    int $LINUX_SYSCALL

    pushl ST_OUTPUT_DESC(%ebp)
    call newline
    addl $4,%esp
    jmp read_record_loop


finished_reading:
    movl $SYS_EXIT,%eax
    movl $0,%ebx
    int $LINUX_SYSCALL
