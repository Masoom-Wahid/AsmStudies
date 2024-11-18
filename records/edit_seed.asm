.include "linux.asm"
.include "def.asm"


.section .data

input_file_name:
    .ascii "test.dat\0"

output_file_name:
    .ascii "output.dat\0"



.section .bss
.lcomm record_buffer,RECORD_SIZE


.equ ST_INPUT_DESC, -4
.equ ST_OUTPUT_DESC, -8

.section .text
.global _start

_start:
    movl %esp,%ebp
    subl $8,%esp

    movl $SYS_OPEN,%eax
    movl $input_file_name,%ebx
    movl $0,%ecx
    movl $0666,%edx
    int $LINUX_SYSCALL

    movl %eax,ST_INPUT_DESC(%ebp)

    movl $SYS_OPEN,%eax
    movl $output_file_name,%ebx
    movl $0101,%ecx
    movl $0666,%edx
    int $LINUX_SYSCALL

    movl %eax,ST_OUTPUT_DESC(%ebp)



loop_begin:
    pushl ST_INPUT_DESC(%ebp)
    pushl $record_buffer
    call read_record
    addl $8,%esp

    cmpl $RECORD_SIZE,%eax
    jne loop_end

    incl record_buffer + RECORD_AGE
    pushl ST_OUTPUT_DESC(%ebp)
    pushl $record_buffer
    call write_record
    addl $8,%esp


    jmp loop_begin

loop_end:
    movl $SYS_EXIT,%eax
    movl $0,%ebx
    int $LINUX_SYSCALL




