format ELF64

public string_to_number
public number_to_string
public length_string

//------------------------------------------------------------------------
;
; "571", 0
; '5' - '0' = 5
; '7' - '0' = 7
; '1' - '0' = 1    
;                   |
;                   |
;                   |
section '.string_to_number' executable
; input :
; rax = string
; output :
; rax = number
string_to_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rbx, rbx
    xor rcx, rcx
    .next_iter:
        cmp [rax+rbx], byte 0
        je .to_number
        mov cl, [rax+rbx]
        sub cl, '0'
        push rcx
        inc rbx
        jmp .next_iter
    .next_step:         // промежуточное значение 
        mov rcx, 1
        xor rax, rax
    .to_number:
        cmp rbx, 0
        je .close
        pop rdx
        imul rdx, rcx
        imul rcx, 10
        add rax, rdx
        dec rbx
        jmp .to_number
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax 
        ret
//-------------------------------------------------------------------------------------
section '.number_to_string' executable
; input :
; rax = number
; rbx = _buffer
; rcx = _buffer.size
number_to_string:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi, rcx
    xor rcx, rcx
    .next_iter:     ; бесконечный цикл
        push rbx        ; для сохранения указателя на буффер
        mov rbx, 10
        xor rdx, rdx    ;обнуление rdx = 0
        div rbx         ; делим rax на rbx = 10
        pop rbx
        add rdx, '0'
        push rdx
        inc rcx         ; счетчик для кол-ва итерраций в цикле
        cmp rax ,0
        je .next_step
        jmp .next_iter
    .next_step:
        mov rdx, rcx
        xor rcx, rcx
    .to_string:
        cmp rcx, rsi
        je .pop_iter
        cmp rcx, 0
        je .close
        pop rax
        mov [rbx+rcx], rax
        inc rcx
        jmp .to_string
    .pop_iter:          ; выгрузка значений из стэка
        cmp rcx, rdx
        je .close
        pop rax
        inc rcx
        jmp .pop_iter

    .close:
        pop rsi
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

//-------------------------------------------------------------------------------------

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

//-------------------------------------------------------------------------------------