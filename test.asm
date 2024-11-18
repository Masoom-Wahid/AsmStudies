.section .data
    data_items:
        .byte 100, 20, 40, 50, 30 

.section .text
.global _start

_start:
    mov $4, %cl             # length of array (4 elements after the first) in cl
    mov $0, %edi            # index = 0
    movb data_items(,%edi,1), %al  # load the first element into al
    movb %al, %bl           # set the highest value in bl initially

start_loop:
    inc %edi                # increment index
    cmp %cl, %dil           # check if end of array is reached
    je loop_exit            # exit if we are at the end
    movb data_items(,%edi,1), %al # load the current element
    cmpb %bl, %al           # compare current highest with current element
    jge start_loop          # if current element is less than or equal to bl, continue
    movb %al, %bl           # update highest value in bl if current is higher
    jmp start_loop

loop_exit:
    mov %ebx, %eax          # move highest value into eax for exit status
    mov $1, %al
    int $0x80

