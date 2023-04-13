global _main
extern _puts

section .text

_main:
    push rbx
    mov rdi, message
    ; lea rdi, [rel message]
    call _puts
    call Human.walk
    pop rbx
    ret

if0:
    mov rax, 0
    ret

section .data

message: db "Hello, World!", 0

Human:
.walk: equ if0
.avrg_height: equ 10