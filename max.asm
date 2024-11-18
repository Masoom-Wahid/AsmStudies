.section .data
    data_items:
        .long 3,67,34,222,45,75,54,34,44,33,22,11,66,254,255,0


.section .text

.global _start


# edi -> index
# ebx -> high value
# eax -> current element


_start:
    movl $0,%edi # mov 0 as index into edi
    movl data_items(,%edi,4), %eax # load the first byte of data into eax 
    movl %eax,%ebx # make the curr element into ebx


start_loop:
    cmpl $0,%eax #check to see if we are at 0
    je loop_exit
    # increment the edi (index)
    incl %edi  
    movl data_items(,%edi,4), %eax 
    cmpl %ebx,%eax # compare highest value with curr element
    # jump if it is not bigger
    jle start_loop 
    movl %eax,%ebx
    jmp start_loop

loop_exit:
    # since the status to OS is in ebx and ebx holds the highest value we can use
    # echo $? to see the result
    movl $1,%eax
    int $0x80
