global _main
extern _puts

section .text

_main:
    push rbx
    lea rdi, [rel message]
    call _puts
    pop rbx
    mov rax, 0
    ret

section .data

message: db "Hello, World!", 0