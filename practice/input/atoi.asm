.type atoi,@function
.global atoi


.equ ST_ATOI_STR,16



atoi:
    push %rbp                   
    mov %rsp, %rbp               
   

    push ST_ATOI_STR(%rbp)
    call print
    add $8,%rsp

 
    push ST_ATOI_STR(%rbp)                    
    call strlen                 
    add $8,%rsp
    

    mov %rax, %rcx
    sub $1,%rcx # minus 1 because of \n 
    mov $0, %rax 

    mov ST_ATOI_STR(%rbp),%rdi

atoi_loop_start:
    cmp $0, %rcx                 # Compare length (RCX) with 0
    je atoi_loop_end             # If RCX is 0, end the loop

    mov (%rdi), %dl              
    sub $48, %dl                 

    imul $10, %rax 
    movzx %dl, %rdx
    add %rdx, %rax

    inc %rdi                     # Move to the next character in the string
    dec %rcx                     # Decrease the length counter
    jmp atoi_loop_start          # Repeat the loop

atoi_loop_end:
    pop %rdi                     # Restore the string pointer from the stack
    mov %rbp, %rsp               # Restore stack pointer
    pop %rbp                     # Restore the base pointer
    ret                          # Return the integer result in RAX

