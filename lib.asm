bits 64

%include "header.asm"

global start

section .text

exit:
    mov rax, SYS_EXIT
    syscall
    ; no "ret" b/c this doesn't return

mmap_alloc: ; int alloc (int size)
    mov rax, SYS_MMAP ; MMAP syscall id
    
    mov r12, rdi ; save given size
    
    add rdi, 8 ; increase count to allow space to store number of allocated bytes
    mov rsi, rdi ; move byte count into correct register
    mov rdi, 0 ; set the preferred address to NULL
    mov rdx, 3;MMAP_PROT_READ | MMAP_PROT_WRITE ; read/write, no execute
    mov rcx, 0x1002;MMAP_PRIVATE | MMAP_ANON ; used for memory allocation
    mov r8, 0 ; sets fd to zero b/c it's not used
    mov r9, 0 ; sets offset to zero b/c it's meaningless w/o a file to offset
    syscall

    cmp rax, 0 ; error check
    jge .noerr
    ret
    
.noerr:
    mov [rax], r12 ; store length
    add rax, 8 ; offset the value in rax so that the pointer doesn't include the preserved size
    ret

mmap_dealloc: ; int dealloc (int pointer)
    mov rax, SYS_MUNMAP ; MUNMAP syscall id
    sub rdi, 8 ; remove mmap_alloc given offset
    mov rsi, [rdi] ; get the size to deallocate
    syscall
    ret

bugprint:
    mov rax, SYS_WRITE
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg.len
    syscall
    ret

start:
    call bugprint

    mov rdi, 2
    call mmap_alloc ; allocate 2 bytes

    call bugprint

    ; check for error
    cmp rax, 0
    jl  err

    mov r12, rax ; the pointer

    ; read 2 characters
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, r12
    mov rdx, 2
    syscall

    ; write those same 2 characters
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, r12
    mov rdx, 2
    syscall

    ; deallocate extra space
    mov rdi, r12 ; pointer
    call mmap_dealloc ; make the call

    mov rdi, 0
    jmp exit

err:
    mov rdi, 1
    jmp exit

section .data

msg: db "debug", 10
.len: equ $-msg