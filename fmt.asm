format ELF64

public print_char
public print_number
public print_string


//------------------------------------------------------------------------------

section '.print_char' executable
; input param -> rax = char
print_char:
    push rax        ; помещение регистра в СТЭК

    mov rax, 1
    mov rdi, 1      ; регистры предназначенные для строк(std::out) 
    mov rsi, rsp    ; регистр rsp берет указатель на последнее значение в СТЭКЕ
    mov rdx, 1      ; кол-во символов
    syscall

    pop rax         ; забираем значение из СТЭКА

    ret

//------------------------------------------------------------------------------

section '.print_number' executable
; input -> rax = number
; будет производиться в цикле деление по остаткам (rax | rdx)
; 571 / 10 = 57 | 1
; 57 / 10 = 5 | 7
; 5 / 10 = 0 | 5
;
print_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    .next_iter:     ; бесконечный цикл
        mov rbx, 10
        xor rdx, rdx    ;обнуление rdx = 0
        div rbx         ; делим rax на rbx = 10
        add rdx, '0'
        push rdx
        inc rcx         ; счетчик для кол-ва итерраций в цикле
        cmp rax ,0
        je .print_iter
        jmp .next_iter

    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

//------------------------------------------------------------------------------

section '.print_string' executable
// функция вывода строки в консоль
// input: rax = string
print_string:
    push rax
    push rbx
    push rcx
    push rdx     // добавление rdx в стэк

    mov rcx, rax // перемещение значения rax в rcx
    call lengt_string
    mov rdx, rax // перемещение длинные в регистр rdx
    mov rax, 4    // запись 
    mov rbx, 1    // вывод в терминал
    int 0x80 //обращение к ОС

    pop rdx     // удаление rdx из стэка
    pop rcx
    pop rbx
    pop rax
    ret

//------------------------------------------------------------------------------