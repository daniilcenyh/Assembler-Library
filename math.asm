format ELF64

public gcd
public fibonacci
public factorial

//----------------------------------------------------------------
section '.factorial' executable
// input: 
// rax = number
// output: 
// rax = number
factorial:
    push rbx
    mov rbx, rax
    mov rax, 1
    .nex_iter:
        cmp rbx, 1
        je .close
        mul rbx
        dec rbx
        jmp .nex_iter
    .close:
        pop rbx
        ret

//----------------------------------------------------------------
section '.fibonacci' executable

// input: 
// rax = number
// output: 
// rax = fibonacci number
fibonacci:
    push rbx
    push rcx
    mov rbx, 0
    mov rcx, 1
    cmp rax, 0
    je .next_step

    .nex_iter:
        cmp rax, 1
        jle .close
        push rcx
        add rcx, rbx
        pop rbx
        dec rax
        jmp .nex_iter
    .next_step:
        xor rcx, rcx
    close:
        mov rax, rcx
        pop rcx
        pop rbx
        ret
//----------------------------------------------------------------
// наибольший общий делитель

section '.gcd' executable

// input: 
// rax = first number
// rbx = second number
// output: 
// rax = greatest common divisor
gcd:
    push rbx
    next_iter:
        cmp rbx, 0
        je .close
        xor rdx, rdx
        div rbx
        push rbx
        mov rbx, rdx
        pop rax
        .next_iter
    close:
        pop rbx
        ret
//----------------------------------------------------------------