.section .data
filename: .asciz "example.txt"   # Null-terminated string for the filename
buffer: .space 1024             # Allocate 1024 bytes for the read buffer


record_size : 
    .long 4096


record_buffer_ptr:
    .long 0



msg_error: .asciz "Error reading file\n"

.section .text
.global _start

_start:

    call allocate_init

    pushl $record_size
    call allocate
    movl %eax,record_buffer_ptr 
    # Open the file
    movl $5, %eax               # System call number for open
    movl $filename, %ebx        # Address of the filename
    movl $0, %ecx               # Flags: O_RDONLY
    int $0x80                   # Make the system call

    # Check if open was successful
    testl %eax, %eax            # Check if eax is negative
    js error_open               # Jump to error handling if open failed

    movl %eax, %ebx             # Save the file descriptor in ebx

read_loop:
    # Read from the file
    movl $3, %eax               # System call number for read
    movl %ebx, %ebx             # File descriptor
    movl record_buffer_ptr, %ecx          # Buffer pointer
    movl $4096, %edx            # Number of bytes to read
    int $0x80                   # Make the system call

    # Check if read was successful
    testl %eax, %eax            # Check if eax is zero or negative
    jle close_file              # Exit loop if end of file or error

    # Write to standard output
    movl $1, %ebx               # File descriptor for stdout
    movl record_buffer_ptr, %ecx          # Buffer pointer
    movl %eax, %edx             # Use the number of bytes read in eax
    movl $4, %eax               # System call number for write

    int $0x80  # Make the system call
    

    movl $1, %eax               # System call number for exit
    movl $110,%ebx            # Exit code 0
    int $0x80                   # Make the system call


close_file:
    # Close the file
    movl $6, %eax               # System call number for close
    movl %ebx, %ebx             # File descriptor
    int $0x80                   # Make the system call

    # Exit program
    movl $1, %eax               # System call number for exit
    xorl %ebx, %ebx             # Exit code 0
    int $0x80                   # Make the system call

error_open:
    # Print error message
    movl $4, %eax               # System call number for write
    movl $1, %ebx               # File descriptor for stdout
    movl $msg_error, %ecx       # Address of the error message
    movl $19, %edx              # Length of the error message
    int $0x80                   # Make the system call

    # Exit with error code
    movl $1, %eax               # System call number for exit
    movl $1, %ebx               # Exit code 1
    int $0x80                   # Make the system call

