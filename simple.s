; nasm -fmacho simple.s && ld -macosx_version_min 10.7.0 -o simple simple.o && ./simple
bits 64

global start


section .text

start:
    mov     rax, 0x2000004 ; write
    mov     rdi, 1 ; stdout
    mov     rsi, msg
    mov     rdx, mlen
    syscall
    mov rax, 0x2000003 ; read
    mov rdi, 0 ; stdin
    mov rsi, input
    mov rdx, 2
    syscall
    mov rcx, input
    mov rbx, [input + 8]
    add rcx, rbx
    mov rax, 0x2000004 ; write
    mov rdi, 1 ; stdout
    mov rsi, input
    mov rdx, 1
    syscall
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    mov     rax, 0x2000001 ; exit
    mov     rdi, 0
    syscall


section .data

msg:    db      "Hello, world!", 10
mlen:   equ     $ - msg
input:  db    "a "
newline: db 10
