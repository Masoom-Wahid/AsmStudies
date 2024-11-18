.include "linux.asm"
.include "def.asm"


.section .data


record2:
    .ascii "Marilyn\0"
    .rept 32 #Padding to 40 bytes
    .byte 0
    .endr
    
    .ascii "Taylor\0"
    .rept 33 #Padding to 40 bytes
    .byte 0
    .endr
    
    .ascii "2224 S Johannan St\nChicago, IL 12345\0"
    .rept 203 #Padding to 240 bytes
    .byte 0
    .endr

    .ascii "29\0"
    .rept 2
    .byte 0
    .endr


record3:
    .ascii "Derrick\0"
    .rept 32 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "McIntire\0"
    .rept 31 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "500 W Oakland\nSan Diego, CA 54321\0"
    .rept 206 #Padding to 240 bytes
    .byte 0
    .endr

    .ascii "36\0"
    .rept 2
    .byte 0
    .endr


file_name:
    .ascii "test.dat\0"

.equ ST_FILE_DESC, -4
.global _start

_start:
    movl %esp,%ebp
    subl $4,%esp


    movl $SYS_OPEN,%eax
    movl $file_name,%ebx
    movl $0101,%ecx

    movl $0666,%edx
    int $LINUX_SYSCALL

    movl %eax,ST_FILE_DESC(%ebp)

    pushl ST_FILE_DESC(%ebp)
    pushl $record2
    call write_record
    addl $8, %esp

    #Write the third record
    pushl ST_FILE_DESC(%ebp)
    pushl $record3
    call write_record
    addl $8, %esp

    #Close the file descriptor
    movl $SYS_CLOSE, %eax
    movl ST_FILE_DESC(%ebp), %ebx
    int $LINUX_SYSCALL

    #Exit the program
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $LINUX_SYSCALL

