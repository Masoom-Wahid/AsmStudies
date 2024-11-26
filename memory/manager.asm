.section .data
heap_begin:
    .long 0

current_break:
    .long 0

.equ HEADER_SIZE,8
.equ HDR_AVAIL_OFFSET, 0
.equ HDR_SIZE_OFFSET, 4


.equ UNAVAILABLE,0
.equ AVAILABLE,1

.equ SYS_BREAK,45

.equ LINUX_SYSCALL,0x80


.section .text


.global allocate_init
.type allocate_init, @function



# if we give 0 to ebx when SYS_BREAK , it returns the curr_break
# this function puts the curr_break to break+1 so to ready the allocate


allocate_init:
    pushl %ebp
    movl %esp,%ebp

    movl $SYS_BREAK,%eax
    movl $0,%ebx
    int $LINUX_SYSCALL

    incl %eax

    movl %eax,current_break
    movl %eax,heap_begin

    movl %ebp,%esp
    popl %ebp
    
    ret


#FUNCTION ALLOCATE
# variables
# %ecx -> holds the size of requested memory
# %eax -> curr memory region being examined
# %ebx -> curr break position
# %edx -> size of curr memeory region


.global allocate
.type allocate, @function
.equ ST_MM_SIZE, 8

allocate:
    pushl %ebp
    movl %esp,%ebp

    movl ST_MM_SIZE(%ebp),%ecx
    movl heap_begin,%eax
    movl current_break,%ebx

allocate_loop_begin:
    cmpl %ebx,%eax # if the curr heap position and the curr_break is equal we need more meory
    je move_break

    movl HDR_SIZE_OFFSET(%eax),%edx
    cmpl $UNAVAILABLE,HDR_AVAIL_OFFSET(%eax)
    je next_location

    cmpl %edx,%ecx
    jle allocate_here


next_location:
    addl $HEADER_SIZE,%eax
    addl %edx,%eax

    jmp allocate_loop_begin


allocate_here:
    movl $UNAVAILABLE,HDR_AVAIL_OFFSET(%eax)
    addl $HEADER_SIZE,%eax

    movl %ebp,%esp
    popl %ebp
    ret

move_break:
    addl $HEADER_SIZE,%ebx
    addl %ecx,%ebx
    pushl %eax
    pushl %ecx
    pushl %ebx
    movl $SYS_BREAK,%eax
    int $LINUX_SYSCALL

    cmpl $0,%eax
    je error

    popl %ebx
    popl %ecx
    popl %eax

    movl $UNAVAILABLE,HDR_AVAIL_OFFSET(%eax)
    movl %ecx,HDR_SIZE_OFFSET(%eax)

    addl $HEADER_SIZE,%eax
    movl %ebx,current_break

    movl %ebp,%esp
    popl %ebp
    ret

error:
    movl $0,%eax
    movl %ebp,%esp
    popl %ebp
    ret


.global deallocate
.type deallocate,@function

.equ ST_MEM_SEG,4
deallocate:
    movl ST_MEM_SEG(%esp),%eax
    subl $HEADER_SIZE,%eax
    movl $AVAILABLE,HDR_AVAIL_OFFSET(%eax)
    ret



