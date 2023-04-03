; use '%include "header.s"' to include this content

; defines basic constants
%define SYS_EXIT   0x2000001 ; exit   : void exit(int rval)
%define SYS_READ   0x2000003 ; read   : user_ssize_t read(int fd, user_addr_t cbuf, user_size_t nbyte)
%define SYS_WRITE  0x2000004 ; write  : user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte)
%define SYS_OPEN   0x2000005 ; open   : int open(user_addr_t path, int flags, int mode)
%define SYS_CLOSE  0x2000006 ; close  : int close(int fd)
%define SYS_MMAP   0x20000c5 ; mmap   : user_addr_t mmap(caddr_t addr, size_t len, int prot, int flags, int fd, off_t pos)
%define SYS_MUNMAP 0x2000049 ; munmap : int munmap(caddr_t addr, size_t len)

; MMAP flags & protections
%define MMAP_PROT_NONE  0x00
%define MMAP_PROT_READ  0x01
%define MMAP_PROT_WRITE 0x02
%define MMAP_PROT_EXEC  0x04
%define MMAP_SHARED     0x0001
%define MMAP_PRIVATE    0x0002
%define MMAP_FIXED      0x0010
%define MMAP_ANON       0x1000

; read/write flags & other defs
%define STDIN  0
%define STDOUT 1
%define STDERR 2