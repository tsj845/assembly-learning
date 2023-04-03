#; nasm -fmacho simple.s && ld -macosx_version_min 10.7.0 -o simple simple.o && ./simple

.globl start


.text

start:
    movq     0x2000004, %rax #; write
    movq     1, %rdi #; stdout
    movq     msg, %rsi
    movq     msg_len, %rdx
    syscall

    movq     0x2000001, %rax #; exit
    movq     0, %rdi
    syscall


.data

msg:
.ascii "Hello, world!\n"
msg_len:
.byte 0x0e
.byte 0x00
.byte 0x00
.byte 0x00
.byte 0x00
.byte 0x00
.byte 0x00
.byte 0x00
