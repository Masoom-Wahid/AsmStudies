.section .data
    data_items:
        .long 10,20,40,50,30 


.section .text

.global _start


# edi -> index
# ebx -> high value
# eax -> current element
# ecx -> length of the arr

_start:
    movl $4,%ecx # put the length of arr in ecx
    movl $0,%edi # mov 0 as index into edi
    movl data_items(,%edi,4), %eax # load the first byte of data into eax 
    movl %eax,%ebx # make the curr element into ebx


start_loop:
    cmpl %edi,%ecx #check to see if we are at the end of arr 
    je loop_exit
    # increment the edi (index)
    incl %edi 
    movl data_items(,%edi,4), %eax 
    cmpl %ebx,%eax # compare lowest value with curr element
    # jump if it is not smaller 
    jge start_loop 
    movl %eax,%ebx
    jmp start_loop

loop_exit:
    # since the status to OS is in ebx and ebx holds the highest value we can use
    # echo $? to see the result
    movl $1,%eax
    int $0x80

