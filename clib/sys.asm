format ELF64

public c_file_create
public c_file_delete
public c_file_open
public c_file_close
public c_file_write
public c_file_read
public c_file_seek
public c_exit

include "./asmlib/sys.inc"

;-------------------------------------------------------------------------------------------------------
section '.c_file_create' executable
c_file_create:
    mov rax, rdi
    mov rbx, rsi
    call file_create
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_file_delete' executable
c_file_delete:
    mov rax, rdi
    call file_delete
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_file_open' executable
c_file_open:
    mov rax, rdi
    mov rbx, rsi
    mov rcx, rdx
    call file_open
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_file_close' executable
c_file_close:
    mov rax, rdi
    call file_close
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_file_write' executable
c_file_write:
    mov rax, rdi
    mov rbx, rsi
    mov rcx, rdx
    call file_write
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_file_read' executable
c_file_read:
    mov rax, rdi
    mov rbx, rsi
    mov rcx, rdx
    call file_read
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_file_seek' executable
c_file_seek:
    mov rax, rdi
    mov rbx, rsi
    mov rcx, rdx
    call file_seek
    ret
;-------------------------------------------------------------------------------------------------------
section '.c_exit' executable
c_file_seek:
    call exit
    ret
;-------------------------------------------------------------------------------------------------------