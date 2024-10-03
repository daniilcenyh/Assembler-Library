FORMAT ELF64

public mult
public print_string

section '.c_print_string' executable
;   input : 1 arg
;   output : false
c_print_string:
    mov rax, rdi
    call print_string
    ret

section '.length_string' executable
// функция вычисления длинны сообщения
// input: rax = string
// output: rax = length
length_string:
    push rdx     // добавление rdx в стэк
    xor rdx, rdx // обнуление rdx = 0
    // цикл
    .next_iter:
        cmp [rax+rdx], byte 0 // сравнение
        je .close
        inc rdx
        jmp .next_iter
    .close:
        mov rax, rdx
        pop rdx
        ret

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

section '.mult' executable
;   input : 2 arguments
;   output : true
mult:
    mov rax, rdi
    mul rsi
    ret

