bits 64

global start

%define _stdout         0x1
%define _stderr         0x2

%define O_RDONLY        0x0000          ; open for reading only
%define O_WRONLY        0x0001          ; open for writing only
%define O_RDWR          0x0002          ; open for reading and writing
%define O_ACCMODE       0x0003          ; mask for above modes
%define O_CREAT         0x0200          ; create if nonexistant 
%define O_TRUNC         0x0400          ; truncate to zero length 
%define O_EXCL          0x0800          ; error if already exists

%define syscall_write   0x2000004
%define syscall_exit    0x2000001
%define syscall_open    0x2000005
%define syscall_close   0x2000006

section .text

start:
; open takes: rdi, rsi, rdx
    mov rax, syscall_open ; open
    mov rdi, fname ; file name
    mov rdx, 0777 ; mode
    mov rsi, 0xA02 ; flags
    syscall

    mov r8, fd
    mov [r8], rax ; store fd
    mov rdi, rax

    mov rax, syscall_write ; write
    mov rsi, fname
    mov rdx, 4
    syscall

    mov rax, syscall_close ; close
    mov rdi, fd
    syscall

    mov rax, syscall_exit ; exit
    mov rdi, 0
    syscall

section .data
    fname: db "test.txt"

section .bss
    fd: resb 4
